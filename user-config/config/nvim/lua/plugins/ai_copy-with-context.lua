return {
  {
    'zhisme/copy_with_context.nvim',
    config = function()
      require('copy_with_context').setup({
        mappings = {
          relative = '<leader>yy',
          absolute = '<leader>yY',
          remote = '<leader>yr',
        },
        formats = {
          default = '@{filepath}:{line}',
          remote = '# {remote_url}',
        },
        trim_lines = false,
      })
    end,
  },
}
