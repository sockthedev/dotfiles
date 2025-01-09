return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require 'gitsigns'
      gitsigns.setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        signcolumn = false,
        signs_staged_enable = true,
      }
      vim.keymap.set(
        'n',
        '<leader>gt',
        ':Gitsigns toggle_signs<cr>',
        { noremap = true, silent = true, desc = '[t]oggle signs column' }
      )
      vim.keymap.set(
        'n',
        '<leader>gb',
        ':Gitsigns blame<cr>',
        { noremap = true, silent = true, desc = 'Toggle [b]lame' }
      )
      vim.keymap.set(
        'n',
        '<leader>gl',
        ':Gitsigns toggle_current_line_blame<cr>',
        { noremap = true, silent = true, desc = 'Toggle [l]ine blame' }
      )
      vim.keymap.set(
        'n',
        '<leader>gs',
        ':Gitsigns stage_hunk<cr>',
        { noremap = true, silent = true, desc = '[s]tage hunk' }
      )
    end,
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    lazy = false,
    config = true,
    keys = {
      {
        '<leader>gn',
        '<cmd>Neogit<cr>',
        desc = '[n]eogit',
      },
    },
  },
}
