return {
  { -- Shows pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup {
        notify = false,
        delay = function(ctx)
          return ctx.plugin and 0 or 400
        end,
        win = {
          border = 'single',
          padding = { 1, 1 },
        },
      }

      -- Document existing key chains
      require('which-key').add {
        { '<C-c>', group = '[C]opilot' },
        { '<C-g>', group = '[G]pt' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>cs', group = '[S]wap' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>g', group = '[G]it' },
        { '<leader>l', group = '[L]sp' },
        { '<leader>p', group = '[P]ersistence' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]est' },
        { '<leader>w', group = '[W]orkspace' },
      }
    end,
  },
}
