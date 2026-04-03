-- Fix LSP keybindings for nvim 0.11+ (override new gr* defaults)
return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          -- Delete nvim 0.11 default gr* mappings
          for _, key in ipairs({ "grn", "gra", "grr", "gri", "grt", "grd" }) do
            pcall(vim.keymap.del, "n", key, { buffer = buffer })
          end

          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc, silent = true })
          end

          -- Traditional LazyVim/IdeaVim keybindings
          map("n", "gd", function() vim.lsp.buf.definition() end, "Goto Definition")
          map("n", "gr", function() vim.lsp.buf.references() end, "References")
          map("n", "gI", function() vim.lsp.buf.implementation() end, "Goto Implementation")
          map("n", "gy", function() vim.lsp.buf.type_definition() end, "Goto Type Definition")
          map("n", "gD", function() vim.lsp.buf.declaration() end, "Goto Declaration")
          map("n", "K", function() vim.lsp.buf.hover() end, "Hover")
          map("n", "gK", function() vim.lsp.buf.signature_help() end, "Signature Help")
          map({ "n", "v" }, "<leader>ca", function() vim.lsp.buf.code_action() end, "Code Action")
          map("n", "<leader>cr", function() vim.lsp.buf.rename() end, "Rename")
        end,
      })
    end,
  },
}
