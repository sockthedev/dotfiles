return {
  'folke/trouble.nvim',
  opts = {
    focus = true,
    win = { position = 'right', size = 0.5 },
  },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>et',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = '[d]iagnostics',
    },
    {
      '<leader>eb',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = '[b]uffer Diagnostics',
    },
    {
      '<leader>es',
      '<cmd>Trouble symbols toggle<cr>',
      desc = '[s]ymbols',
    },
    {
      '<leader>el',
      '<cmd>Trouble lsp toggle<cr>',
      desc = '[l]SP definitions / references / ...',
    },
    {
      '<leader>eo',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'L[o]cation list',
    },
    {
      '<leader>eq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = '[q]uickfix List',
    },
  },
}
