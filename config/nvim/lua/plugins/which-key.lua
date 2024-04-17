return {
  { -- Shows pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<C-g>'] = { name = '[G]pt', c = { name = '[C]hat' }, i = { name = '[I]nline' } },
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
