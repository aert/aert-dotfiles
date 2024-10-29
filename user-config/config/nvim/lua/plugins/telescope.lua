return {
  -- add telescope-fzf-native
  {
    "nvim-telescope/telescope.nvim",

    dependencies = {
      {
        "nvim-telescope/telescope-frecency.nvim",
        keys = {
          { "<leader>fr", "<cmd>Telescope frecency<cr>", mode = "n", desc = "Recent" },
          { "<leader>fR", "<cmd>Telescope frecency workspace=CWD<cr>", mode = "n", desc = "Recent (cwd)" },
        },
      },
    },

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
