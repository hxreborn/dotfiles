# Vim Cheatsheet

## Text Objects

Pattern: `{operator}{i|a}{object}` where `i` = inner, `a` = around

| Keys | Selects |
|------|---------|
| `vi{` `viB` | Inside `{ }` |
| `va{` `vaB` | Around `{ }` |
| `vi(` `vib` | Inside `( )` |
| `va(` `vab` | Around `( )` |
| `vi[` | Inside `[ ]` |
| `vi"` `vi'` | Inside quotes |
| `vit` | Inside HTML tag |
| `viw` | Inner word |
| `vip` | Inner paragraph |

Works with any operator: `d` (delete), `c` (change), `y` (yank)

```
di{  → delete inside braces
ci(  → change inside parens
ya"  → yank around quotes
dip  → delete paragraph
```

## Surround (mini.surround)

| Keys | Action |
|------|--------|
| `sa` | Add surround |
| `sd` | Delete surround |
| `sf` | Find surround |
| `sF` | Find left surround |
| `sr` | Replace surround |
| `sn` | Update n lines |
| `S"` | Surround visual selection |

**Examples**:
- `sa"` → Add quotes around word
- `sd"` → Delete surrounding quotes
- `ysiw{` → Surround word with braces

## Flash (Quick Jump)

| Keys | Action |
|------|--------|
| `s` + 2 chars | Jump to match |
| `S` | Treesitter jump |
| `r` (operator) | Remote flash |
| `Ctrl+s` | Flash search |

## Comments

| Keys | Action |
|------|--------|
| `gcc` | Toggle line comment |
| `gc` + motion | Comment motion (e.g., `gcip`) |
| `gc` in visual | Comment selection |

## Navigation

### Cursor Movement
| Keys | Action |
|------|--------|
| `h j k l` | Left/down/up/right |
| `w b` | Word forward/back |
| `e b` | End of word forward/back |
| `0 $` | Line start/end |
| `gg G` | File start/end |
| `{ }` | Paragraph up/down |
| `Ctrl+u/d` | Half page up/down |
| `%` | Jump to matching bracket |

### Insert Mode Navigation (NEW)
| Keys | Action | Mode |
|------|------|--------|
| `Alt+h` | Move left | Insert, Command |
| `Alt+j` | Move down | Insert, Command |
| `Alt+k` | Move up | Insert, Command |
| `Alt+l` | Move right | Insert, Command |

### Window Navigation
| Keys | Action |
|------|--------|
| `Ctrl+h/j/k/l` | Move focus to left/lower/upper/right window |
| `Shift+H` | Previous tab |
| `Shift+L` | Next tab |

### LSP Navigation
| Keys | Action |
|------|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gi` | Go to implementation |
| `gt` | Go to type |
| `K` | Show documentation |
| `]d` `[d` | Next/prev error |
| `]h` `[h` | Next/prev git hunk |

## Window/Buffer

| Keys | Action |
|------|--------|
| `Ctrl+h/j/k/l` | Navigate splits |
| `Shift+H` | Previous tab |
| `Shift+L` | Next tab |
| `Alt+j/k` | Move line down/up |
| `Ctrl+s` | Save all |

## Leader Commands (Space)

### Find
| Keys | Action |
|------|--------|
| `ff` | Find file |
| `fg` `/` | Grep/search project |
| `fr` `fb` | Recent files |
| `ft` | Terminal |

### Code
| Keys | Action |
|------|--------|
| `ca` | Code actions |
| `cr` | Rename |
| `cf` | Format |
| `cd` | Line diagnostics |

### Git
| Keys | Action |
|------|--------|
| `gg` | Git status |
| `gc` | Commit |
| `gd` | Diff |
| `gh` | File history |
| `gb` | Branches |
| `gn` | Neogit status |
| `<leader>ghb` | Blame line (full info) |
| `<leader>ghB` | Blame buffer |

### UI Toggles
| Keys | Action |
|------|--------|
| `ul` | Toggle relative numbers |
| `uw` | Toggle wrap |
| `uh` | Toggle search highlight |

### Buffer
| Keys | Action |
|------|--------|
| `bb` | Switch buffer |
| `bd` | Close buffer |
| `bo` | Close other buffers |

### Windows
| Keys | Action |
|------|--------|
| `wd` | Close window |
| `wm` | Maximize window |
| `-` | Split horizontal |
| `\|` | Split vertical |

### Search
| Keys | Action |
|------|--------|
| `sg` | Live grep |
| `sr` | Search & replace |
| `ss` | Go to symbol |
| `sw` | Search word under cursor |

### Other
| Keys | Action |
|------|--------|
| `e` | File explorer |
| `qq` | Quit |

## Run/Debug

| Keys | Action |
|------|--------|
| `rr` | Run |
| `rd` | Debug |
| `rs` | Stop |

## Refactoring

| Keys | Action |
|------|--------|
| `rm` | Extract method |
| `rv` | Extract variable |
| `ri` | Inline |
| `<leader>rn` | Rename symbol (LSP) |
| `gi` | Go to implementation (LSP) |
| `gr` | Find references (LSP) |

## Indentation (guess-indent.nvim)

**Auto-detects indentation style** when opening files
- Works with BufReadPost/BufNewFile events
- Zero configuration needed
- Consistent across projects

## Basic Motions

| Keys | Action |
|------|--------|
| `h j k l` | Left/down/up/right |
| `w b` | Word forward/back |
| `e b` | End of word forward/back |
| `0 $` | Line start/end |
| `gg G` | File start/end |
| `{ }` | Paragraph up/down |
| `Ctrl+u/d` | Half page up/down |
| `%` | Jump to matching bracket |
| `f{char}` | Find char forward |
| `t{char}` | Till char forward |

**Tip**: Use `Alt+h/j/k/l` in Insert mode for navigation without exiting
