return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = {
          settings = {
            kotlin = {
              compiler = {
                jvm = {
                  target = "21",
                },
              },
              indexing = {
                enabled = true,
              },
              externalSources = {
                autoConvertToKotlin = false,
              },
            },
          },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            -- Skip submodules - find the outermost Gradle project
            local root = util.root_pattern("settings.gradle.kts", "settings.gradle")(fname)
            if root then
              -- Check if this is inside a submodule by looking for parent settings.gradle.kts
              local parent = vim.fn.fnamemodify(root, ":h")
              while parent and parent ~= "/" do
                local parent_settings = parent .. "/settings.gradle.kts"
                if vim.fn.filereadable(parent_settings) == 1 then
                  root = parent
                end
                parent = vim.fn.fnamemodify(parent, ":h")
              end
            end
            return root or util.root_pattern(".git")(fname)
          end,
        },
      },
    },
  },
}
