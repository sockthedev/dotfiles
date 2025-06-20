return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      local snacks = require 'snacks'

      snacks.setup {
        bufdelete = {},
        bigfile = {
          notify = true,
          size = 1.5 * 1024 * 1024, -- 1.5MB
        },
        indent = {},
        image = {},
        -- input = {
        --   border = 'single',
        --   height = 3,
        -- },
        lazygit = {
          theme = {
            selectedLineBgColor = { bg = 'default' },
          },
        },
        scratch = {},
        words = {
          notify_end = false,
        },
      }

      -- Scratch
      vim.keymap.set({ 'n', 'v' }, "<leader>'", function()
        snacks.scratch()
      end, { desc = 'Scratch' })
      vim.keymap.set({ 'n', 'v' }, '<leader>;', function()
        snacks.scratch.select()
      end, { desc = 'Scratch Select' })

      -- Lazygit
      vim.keymap.set('n', '<leader>gg', function()
        snacks.lazygit.open()
      end, { desc = 'lazy[g]it' })
      vim.keymap.set('n', '<leader>gf', function()
        snacks.lazygit.log_file()
      end, { desc = '[f]ile log' })
      vim.keymap.set('n', '<leader>gl', function()
        snacks.lazygit.log()
      end, { desc = '[l]og' })

      -- Words jumping
      vim.keymap.set('n', '<C-f>', function()
        snacks.words.jump(1, true)
      end, { desc = 'jump [f]orward word' })
      vim.keymap.set('n', '<C-b>', function()
        snacks.words.jump(-1, true)
      end, { desc = 'jump [b]ackwards word' })

      -- Buffers
      vim.keymap.set('n', '<leader>bo', function()
        snacks.bufdelete.other()
      end, { desc = 'close [o]ther' })
      vim.keymap.set('n', '<leader>ba', function()
        snacks.bufdelete.all()
      end, { desc = 'close [a]ll' })
      vim.keymap.set('n', '<leader>bc', function()
        snacks.bufdelete.delete()
      end, { desc = 'close [c]urrent' })
    end,
  },
}
