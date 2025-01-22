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
        layout = {
          spacing = 2,
        },
        icons = {
          mappings = false,
          colors = false,
        },
      }

      -- Document existing key chains
      require('which-key').add {
        { '<C-g>', group = 'Gpt' },
        { '<C-t>', group = 'Sniprun' },
        { '<C-w>', group = 'Window' },
        { '<leader>c', group = '[c]ode' },
        { '<leader>cs', group = '[s]wap' },
        { '<leader>d', group = '[d]ap' },
        { '<leader>f', group = '[f]ind and replace' },
        { '<leader>g', group = '[g]it' },
        { '<leader>l', group = '[l]sp' },
        { '<leader>s', group = '[s]ession' },
        { '<leader>t', group = '[t]elescope' },
        { '<leader>u', group = '[u]nit tests' },
        { '<leader>x', group = 'diagnosti[x]' },
      }
    end,
  },
}
