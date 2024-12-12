return {
  'folke/trouble.nvim',
  opts = {
    focus = true,
    win = { position = 'right', size = 0.5 },
  },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>xd',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = '[d]iagnostics',
    },
    {
      '<leader>xb',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = '[b]uffer Diagnostics',
    },
    {
      '<leader>xs',
      '<cmd>Trouble symbols toggle<cr>',
      desc = '[s]ymbols',
    },
    {
      '<leader>xl',
      '<cmd>Trouble lsp toggle<cr>',
      desc = '[l]SP definitions / references / ...',
    },
    {
      '<leader>xo',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'L[o]cation list',
    },
    {
      '<leader>xq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = '[q]uickfix List',
    },
  },
}
