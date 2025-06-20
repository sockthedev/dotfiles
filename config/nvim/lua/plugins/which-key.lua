return {
  { -- Shows pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup {
        notify = false,
        -- delay between pressing a key and opening which-key (milliseconds)
        -- this setting is independent of vim.opt.timeoutlen
        delay = 0,
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
        { '<leader>b', group = '[b]uffers' },
        { '<leader>c', group = '[c]ode' },
        { '<leader>cs', group = '[s]wap' },
        { '<leader>d', group = '[d]ap' },
        { '<leader>e', group = '[e]rrors' },
        { '<leader>f', group = '[f]ind and replace' },
        { '<leader>g', group = '[g]it' },
        { '<leader>l', group = '[l]sp' },
        { '<leader>s', group = '[s]ession' },
        { '<leader>t', group = '[t]elescope' },
        { '<leader>u', group = '[u]nit tests' },
      }
    end,
  },
}
