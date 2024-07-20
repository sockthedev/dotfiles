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
        { '<leader>c', group = '[c]ode' },
        { '<leader>cs', group = '[s]wap' },
        { '<leader>f', group = '[f]ind and replace' },
        { '<leader>g', group = '[g]it' },
        { '<leader>l', group = '[l]sp' },
        { '<leader>p', group = '[p]ersistence' },
        { '<leader>t', group = '[t]elescope' },
        { '<leader>u', group = '[u]nit tests' },
      }
    end,
  },
}
