return {
  "lewis6991/gitsigns.nvim",
  opts = function(_, opts)
    local original_on_attach = opts.on_attach

    opts.on_attach = function(buffer)
      if original_on_attach then
        original_on_attach(buffer)
      end

      local gs = require("gitsigns")

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- Navigate hunks with inline preview
      local function nav_and_preview(direction)
        gs.nav_hunk(direction)
        -- Need to wait for cursor to settle, then trigger preview
        vim.defer_fn(function()
          vim.cmd("Gitsigns preview_hunk_inline")
        end, 300)
      end

      map("n", "]h", function()
        if vim.wo.diff then return "]c" end
        nav_and_preview("next")
      end, "Next Hunk")

      map("n", "[h", function()
        if vim.wo.diff then return "[c" end
        nav_and_preview("prev")
      end, "Prev Hunk")

      -- Delete any existing mappings first
      pcall(vim.keymap.del, "n", "]H", { buffer = buffer })
      pcall(vim.keymap.del, "n", "[H", { buffer = buffer })

      vim.keymap.set("n", "]H", function()
        nav_and_preview("last")
      end, { buffer = buffer, desc = "Last Hunk" })

      vim.keymap.set("n", "[H", function()
        nav_and_preview("first")
      end, { buffer = buffer, desc = "First Hunk" })

      -- Hunk actions (leader gh)
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>ghP", gs.preview_hunk, "Preview Hunk Popup")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghB", gs.blame, "Blame Buffer")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")

      -- Esc to close preview
      map("n", "<Esc>", function()
        vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_create_namespace("gitsigns_preview_inline"), 0, -1)
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_config(win).relative ~= "" then
            pcall(vim.api.nvim_win_close, win, true)
          end
        end
        vim.cmd("nohlsearch")
      end, "Close preview / clear search")
    end
  end,
}
