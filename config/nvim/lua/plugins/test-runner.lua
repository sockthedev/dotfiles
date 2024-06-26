return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'antoinemadec/FixCursorHold.nvim',
    'marilari88/neotest-vitest',
    'haydenmeade/neotest-jest',
    'nvim-neotest/nvim-nio',
    'nvim-neotest/neotest-go',
  },
  config = function()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)

    require('neotest').setup {
      adapters = {
        require 'neotest-vitest',
        require 'neotest-jest' {
          jestCommand = 'npm test --',
          jestConfigFile = 'custom.jest.config.ts',
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
        require 'neotest-go',
      },
      quickfix = {
        enabled = false,
      },
    }

    vim.keymap.set('n', '<leader>tt', function()
      require('neotest').run.run()
    end, { desc = 'Run nearest test' })

    vim.keymap.set('n', '<leader>tf', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = 'Run current file' })

    vim.keymap.set('n', '<leader>td', function()
      require('neotest').run.run { strategy = 'dap' }
    end, { desc = 'Debug nearest test' })

    vim.keymap.set('n', '<leader>ts', function()
      require('neotest').run.stop()
    end, { desc = 'Stop nearest test' })

    vim.keymap.set('n', '<leader>ta', function()
      require('neotest').run.attach()
    end, { desc = 'Attach to nearest test' })

    vim.keymap.set('n', '<leader>tl', function()
      require('neotest').run.run_last()
    end, { desc = 'Run last test' })

    vim.keymap.set('n', '<leader>to', function()
      require('neotest').output.open { enter = true }
    end, { desc = 'Open test output' })

    vim.keymap.set('n', '<leader>tp', function()
      require('neotest').output_panel.toggle()
    end, { desc = 'Toggle output panel' })
  end,
}
