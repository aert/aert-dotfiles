return {
  -- add telescope-fzf-native
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")
      opts.defaults = {
        mappings = {
          i = {
            ["<c-t>"] = actions.select_tab,
          },
        },
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
      }
    end,
  },
}
