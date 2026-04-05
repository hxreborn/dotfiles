return {

  "nvim-mini/mini.surround",

  version = false,

  event = "VeryLazy",

  opts = {
    -- Add custom mappings if desired
    mappings = {
      add = "sa", -- Surround with add
      delete = "sd", -- Delete surrounding
      find = "sf", -- Find surrounding
      find_left = "sF", -- Find left surrounding
      replace = "sr", -- Replace surrounding
      update_n_lines = "sn", -- Update `n` lines
    },
  },

}
