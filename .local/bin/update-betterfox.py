#!/usr/bin/env python3
"""
Update Betterfox user.js to the latest upstream version while preserving:
- SMOOTHFOX scrolling overrides
- MY OVERRIDES section
- Any post-BETTERFOX sections (e.g. GWFOX)
"""

import argparse
import configparser
import difflib
import os
import platform
import re
import shutil
import sys
import urllib.request
from datetime import datetime
from pathlib import Path

UPSTREAM_URL = "https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js"

# Section boundary patterns
RE_SECTION = re.compile(
    r"^/\*{10,}.*?\*{10,}/\s*$", re.MULTILINE | re.DOTALL
)
SMOOTHFOX_HEADER = "SECTION: SMOOTHFOX"
OVERRIDES_HEADER = "START: MY OVERRIDES"
END_MARKER = "END: BETTERFOX"


def detect_profiles() -> list[Path]:
    """Return Firefox profile dirs that contain a user.js, sorted by mtime."""
    system = platform.system()
    if system == "Darwin":
        base = Path.home() / "Library" / "Application Support" / "Firefox"
    elif system == "Linux":
        base = Path.home() / ".mozilla" / "firefox"
    elif system == "Windows":
        base = Path(os.environ.get("APPDATA", "")) / "Mozilla" / "Firefox"
    else:
        sys.exit(f"Unsupported platform: {system}")

    profiles_ini = base / "profiles.ini"
    if not profiles_ini.exists():
        sys.exit(f"Firefox profiles.ini not found at {profiles_ini}")

    config = configparser.ConfigParser()
    config.read(profiles_ini)

    dirs: list[Path] = []
    for section in config.sections():
        if not section.startswith("Profile"):
            continue
        path = config.get(section, "Path", fallback=None)
        is_relative = config.getboolean(section, "IsRelative", fallback=True)
        if path is None:
            continue
        profile_dir = base / path if is_relative else Path(path)
        if (profile_dir / "user.js").exists():
            dirs.append(profile_dir)

    dirs.sort(key=lambda p: (p / "user.js").stat().st_mtime, reverse=True)
    return dirs


def pick_profile(profiles: list[Path]) -> Path:
    """Let the user choose a profile interactively."""
    if not profiles:
        sys.exit("No Firefox profiles with a user.js found.")
    if len(profiles) == 1:
        print(f"Found profile: {profiles[0].name}")
        return profiles[0]

    print("Multiple profiles with user.js found:")
    for i, p in enumerate(profiles, 1):
        mtime = datetime.fromtimestamp((p / "user.js").stat().st_mtime)
        print(f"  [{i}] {p.name}  (last modified: {mtime:%Y-%m-%d %H:%M})")
    while True:
        choice = input("Select profile [1]: ").strip() or "1"
        if choice.isdigit() and 1 <= int(choice) <= len(profiles):
            return profiles[int(choice) - 1]
        print("Invalid choice.")


def fetch_upstream() -> str:
    """Download the latest Betterfox user.js."""
    print(f"Fetching latest Betterfox from upstream...")
    req = urllib.request.Request(UPSTREAM_URL, headers={"User-Agent": "update-betterfox/1.0"})
    with urllib.request.urlopen(req, timeout=15) as resp:
        text = resp.read().decode("utf-8")
    # extract version
    m = re.search(r"version:\s*(\d+)", text)
    ver = m.group(1) if m else "unknown"
    print(f"Fetched upstream version: {ver}")
    return text


def extract_version(text: str) -> str:
    m = re.search(r"version:\s*(\d+)", text)
    return m.group(1) if m else "unknown"


def find_section_blocks(text: str) -> list[tuple[str, int, int]]:
    """
    Return a list of (header_text, start_offset, end_offset) for each
    main banner-delimited section (the /***...***/ blocks).
    Only matches banners containing SECTION:, START:, or END: to avoid
    picking up sub-banners (e.g. OPTION: INSTANT SCROLLING inside SMOOTHFOX).
    """
    blocks = []
    for m in RE_SECTION.finditer(text):
        banner = m.group()
        if any(kw in banner for kw in ("SECTION:", "START:", "END:")):
            blocks.append((banner, m.start(), m.end()))
    return blocks


def extract_between_markers(text: str, start_keyword: str, end_keyword: str) -> str | None:
    """
    Extract text between two banner sections identified by keywords.
    Returns the content between the end of the start-banner and the
    beginning of the end-banner, or None if not found.
    """
    blocks = find_section_blocks(text)
    start_end = None
    end_start = None
    for banner, bstart, bend in blocks:
        if start_keyword in banner:
            start_end = bend
        if end_keyword in banner and start_end is not None:
            end_start = bstart
            break
    if start_end is not None and end_start is not None:
        return text[start_end:end_start]
    return None


def extract_smoothfox_content(text: str) -> str | None:
    """Extract user content inside the SMOOTHFOX section."""
    blocks = find_section_blocks(text)
    smooth_end = None
    next_start = None
    for i, (banner, bstart, bend) in enumerate(blocks):
        if SMOOTHFOX_HEADER in banner:
            smooth_end = bend
            if i + 1 < len(blocks):
                next_start = blocks[i + 1][1]
            break
    if smooth_end is None:
        return None
    content = text[smooth_end:next_start] if next_start else text[smooth_end:]
    # strip the default placeholder comments that come with upstream
    lines = content.splitlines(keepends=True)
    user_lines = []
    hit_user_content = False
    for line in lines:
        stripped = line.strip()
        if not hit_user_content:
            # skip blank lines and the two stock comments
            if stripped == "" or stripped.startswith("// visit") or stripped.startswith("// Enter"):
                user_lines.append(line)
                continue
            hit_user_content = True
        user_lines.append(line)
    # check if there's actual user content
    has_prefs = any("user_pref" in l for l in user_lines)
    return "".join(user_lines) if has_prefs else None


def extract_overrides_content(text: str) -> str | None:
    """Extract user content inside the MY OVERRIDES section."""
    blocks = find_section_blocks(text)
    override_end = None
    next_start = None
    for i, (banner, bstart, bend) in enumerate(blocks):
        if OVERRIDES_HEADER in banner:
            override_end = bend
            if i + 1 < len(blocks):
                next_start = blocks[i + 1][1]
            break
    if override_end is None:
        return None
    content = text[override_end:next_start] if next_start else text[override_end:]
    lines = content.splitlines(keepends=True)
    user_lines = []
    hit_user_content = False
    for line in lines:
        stripped = line.strip()
        if not hit_user_content:
            if stripped == "" or stripped.startswith("// visit") or stripped.startswith("// Enter"):
                user_lines.append(line)
                continue
            hit_user_content = True
        user_lines.append(line)
    has_prefs = any("user_pref" in l or (l.strip() and not l.strip().startswith("//")) for l in user_lines if l.strip())
    return "".join(user_lines) if has_prefs else None


def extract_post_betterfox(text: str) -> str | None:
    """Extract everything after the END: BETTERFOX banner."""
    blocks = find_section_blocks(text)
    for banner, bstart, bend in blocks:
        if END_MARKER in banner:
            remainder = text[bend:]
            if remainder.strip():
                return remainder
            return None
    return None


def inject_into_upstream(
    upstream: str,
    smoothfox_content: str | None,
    overrides_content: str | None,
    post_betterfox: str | None,
) -> str:
    """Inject preserved user sections into the fresh upstream template."""
    result = upstream

    # inject smoothfox content
    if smoothfox_content is not None:
        blocks = find_section_blocks(result)
        for i, (banner, bstart, bend) in enumerate(blocks):
            if SMOOTHFOX_HEADER in banner:
                # find the next section
                if i + 1 < len(blocks):
                    next_start = blocks[i + 1][1]
                else:
                    next_start = len(result)
                result = result[:bend] + smoothfox_content + result[next_start:]
                break

    # inject overrides content
    if overrides_content is not None:
        blocks = find_section_blocks(result)
        for i, (banner, bstart, bend) in enumerate(blocks):
            if OVERRIDES_HEADER in banner:
                if i + 1 < len(blocks):
                    next_start = blocks[i + 1][1]
                else:
                    next_start = len(result)
                result = result[:bend] + overrides_content + result[next_start:]
                break

    # append post-betterfox content
    if post_betterfox is not None:
        result = result.rstrip("\n") + "\n" + post_betterfox

    # ensure trailing newline
    if not result.endswith("\n"):
        result += "\n"

    return result


def show_diff(old: str, new: str, path: str) -> None:
    old_lines = old.splitlines(keepends=True)
    new_lines = new.splitlines(keepends=True)
    diff = difflib.unified_diff(old_lines, new_lines, fromfile=f"{path} (current)", tofile=f"{path} (updated)")
    diff_text = "".join(diff)
    if not diff_text:
        print("No changes detected.")
        return
    # colorize if terminal supports it
    for line in diff_text.splitlines(keepends=True):
        if line.startswith("+++") or line.startswith("---"):
            sys.stdout.write(f"\033[1m{line}\033[0m")
        elif line.startswith("+"):
            sys.stdout.write(f"\033[32m{line}\033[0m")
        elif line.startswith("-"):
            sys.stdout.write(f"\033[31m{line}\033[0m")
        elif line.startswith("@@"):
            sys.stdout.write(f"\033[36m{line}\033[0m")
        else:
            sys.stdout.write(line)


def show_change_summary(old: str, new: str) -> None:
    """Print a summary of added/removed/changed prefs."""
    def parse_prefs(text: str) -> dict[str, str]:
        prefs = {}
        for m in re.finditer(r'user_pref\("([^"]+)",\s*(.+?)\);', text):
            prefs[m.group(1)] = m.group(2).strip()
        return prefs

    old_prefs = parse_prefs(old)
    new_prefs = parse_prefs(new)

    added = set(new_prefs) - set(old_prefs)
    removed = set(old_prefs) - set(new_prefs)
    changed = {k for k in set(old_prefs) & set(new_prefs) if old_prefs[k] != new_prefs[k]}

    if added:
        print(f"\n\033[32m+ {len(added)} pref(s) added:\033[0m")
        for k in sorted(added):
            print(f"    {k} = {new_prefs[k]}")
    if removed:
        print(f"\n\033[31m- {len(removed)} pref(s) removed:\033[0m")
        for k in sorted(removed):
            print(f"    {k} = {old_prefs[k]}")
    if changed:
        print(f"\n\033[33m~ {len(changed)} pref(s) changed:\033[0m")
        for k in sorted(changed):
            print(f"    {k}: {old_prefs[k]} -> {new_prefs[k]}")
    if not (added or removed or changed):
        print("\nNo pref-level changes detected.")


def main():
    parser = argparse.ArgumentParser(description="Update Betterfox user.js preserving overrides")
    parser.add_argument("--profile", type=Path, help="Path to Firefox profile directory")
    parser.add_argument("--no-backup", action="store_true", help="Skip creating a backup")
    parser.add_argument("--yes", "-y", action="store_true", help="Apply without confirmation")
    parser.add_argument("--diff-only", action="store_true", help="Show diff and exit without writing")
    args = parser.parse_args()

    # resolve profile
    if args.profile:
        profile_dir = args.profile
        if not (profile_dir / "user.js").exists():
            sys.exit(f"No user.js found in {profile_dir}")
    else:
        profiles = detect_profiles()
        profile_dir = pick_profile(profiles)

    user_js_path = profile_dir / "user.js"
    print(f"Profile: {profile_dir.name}")

    # read current
    current_text = user_js_path.read_text(encoding="utf-8")
    current_ver = extract_version(current_text)
    print(f"Current version: {current_ver}")

    # fetch upstream
    upstream_text = fetch_upstream()
    upstream_ver = extract_version(upstream_text)

    if current_ver == upstream_ver:
        print(f"Already on the latest version ({current_ver}). Nothing to do.")
        sys.exit(0)

    # extract preserved sections from current
    smoothfox = extract_smoothfox_content(current_text)
    overrides = extract_overrides_content(current_text)
    post_bf = extract_post_betterfox(current_text)

    if smoothfox:
        count = smoothfox.count("user_pref")
        print(f"Preserved SMOOTHFOX: {count} pref(s)")
    if overrides:
        count = overrides.count("user_pref")
        print(f"Preserved MY OVERRIDES: {count} pref(s)")
    if post_bf:
        sections = re.findall(r"SECTION:\s*(\w+)", post_bf)
        label = ", ".join(sections) if sections else "custom content"
        print(f"Preserved post-BETTERFOX: {label}")

    # merge
    merged = inject_into_upstream(upstream_text, smoothfox, overrides, post_bf)

    # show summary and diff
    print(f"\n{'='*60}")
    print(f"  Changes: v{current_ver} -> v{upstream_ver}")
    print(f"{'='*60}")
    show_change_summary(current_text, merged)
    print(f"\n{'='*60}")
    print("  Full diff")
    print(f"{'='*60}\n")
    show_diff(current_text, merged, str(user_js_path))

    if args.diff_only:
        sys.exit(0)

    # confirm
    if not args.yes:
        answer = input("\nApply this update? [y/N]: ").strip().lower()
        if answer not in ("y", "yes"):
            print("Aborted.")
            sys.exit(0)

    # backup
    if not args.no_backup:
        backup_path = user_js_path.with_suffix(f".v{current_ver}.bak")
        shutil.copy2(user_js_path, backup_path)
        print(f"Backup: {backup_path.name}")

    # write
    user_js_path.write_text(merged, encoding="utf-8")
    print(f"Updated user.js to Betterfox v{upstream_ver}")
    print("Restart Firefox for changes to take effect.")


if __name__ == "__main__":
    main()
