return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    init = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type for details
      }
    end,
    keys = {
      { "<leader>o", nil, desc = "AI/OpenCode" },
      { "<leader>oa", function() require("opencode").ask("@this: ") end, mode = { "n", "x" }, desc = "Ask OpenCode" },
      { "<leader>ox", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Select OpenCode" },
      { "<leader>ou", function() require("opencode").command("session.half.page.up") end, desc = "Scroll OpenCode up" },
      { "<leader>od", function() require("opencode").command("session.half.page.down") end, desc = "Scroll OpenCode down" },
      { "go", function() return require("opencode").operator("@this ") end, mode = { "n", "x" }, expr = true, desc = "Append range to OpenCode" },
      { "goo", function() return require("opencode").operator("@this ") .. "_" end, expr = true, desc = "Append line to OpenCode" },
    },
  }
}
