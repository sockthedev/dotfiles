return {
  -- Shows color inline for the various colour codes
  {
    'uga-rosa/ccc.nvim',
    config = function()
      require('ccc').setup {
        highlighter = {
          auto_enable = true,
          lsp = true,
          filetypes = {
            'css',
            -- 'tailwind',
            'typescript',
            'typescriptreact',
            'html',
          },
        },
      }
    end,
  },
}
