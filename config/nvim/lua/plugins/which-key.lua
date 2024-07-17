return {
  { -- Shows pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup {
        notify = false,
        win = {
          border = 'single',
          padding = { 1, 1 },
        },
      }

      -- Document existing key chains
      require('which-key').register {
        { '<C-c>', group = '[C]opilot' },
        { '<C-g>', group = '[G]pt' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>g', group = '[G]it' },
        { '<leader>p', group = '[P]ersistence' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]est' },
        { '<leader>w', group = '[W]orkspace' },
      }
    end,
  },
}
