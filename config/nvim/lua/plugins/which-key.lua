return {
  { -- Shows pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup {
        window = {
          border = 'single',
        },
      }

      -- Document existing key chains
      require('which-key').register {
        ['<C-c>'] = { name = '[C]opilot' },
        ['<C-g>'] = { name = '[G]pt' },
        ['<leader>c'] = { name = '[C]ode' },
        ['<leader>d'] = { name = '[D]ocument' },
        ['<leader>g'] = { name = '[G]it' },
        ['<leader>p'] = { name = '[P]ersistence' },
        ['<leader>s'] = { name = '[S]earch' },
        ['<leader>t'] = { name = '[T]est' },
        ['<leader>w'] = { name = '[W]orkspace' },
      }
    end,
  },
}
