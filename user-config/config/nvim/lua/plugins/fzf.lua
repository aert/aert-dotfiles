return {
  {
    "ibhagwan/fzf-lua",

    opts = function(_, opts)
      local fzf = require("fzf-lua")
      local config = fzf.config
      local actions = fzf.actions

      config.defaults.actions.files["ctrl-t"] = actions.file_tabedit
      config.defaults.winopts.fullscreen = true
      config.defaults.winopts.preview.layout = "vertical"
      config.defaults.winopts.preview.hidden = true
    end,
  },
}
