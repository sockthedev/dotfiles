return {
  'folke/zen-mode.nvim',
  opts = {
    window = {
      backdrop = 1,
      width = 1, -- 100%
      height = 1, -- 100%
      options = {
        signcolumn = 'yes',
        number = true,
        relativenumber = true,
        cursorline = false,
        cursorcolumn = false,
        foldcolumn = '0',
      },
    },
  },
  keys = {
    { '<leader>z', '<cmd>ZenMode<cr>', desc = 'Zen Mode' },
  },
}
