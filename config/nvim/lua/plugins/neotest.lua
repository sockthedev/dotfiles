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

    vim.keymap.set('n', '<leader>ur', function()
      require('neotest').run.run()
    end, { desc = '[r]un nearest test' })

    vim.keymap.set('n', '<leader>uf', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = 'Run [f]ile' })

    vim.keymap.set('n', '<leader>ud', function()
      require('neotest').run.run { strategy = 'dap' }
    end, { desc = '[d]ebug nearest test' })

    vim.keymap.set('n', '<leader>us', function()
      require('neotest').run.stop()
    end, { desc = '[s]top nearest test' })

    vim.keymap.set('n', '<leader>ua', function()
      require('neotest').run.attach()
    end, { desc = '[a]ttach nearest test' })

    vim.keymap.set('n', '<leader>ul', function()
      require('neotest').run.run_last()
    end, { desc = 'Run [l]ast test' })

    vim.keymap.set('n', '<leader>uo', function()
      require('neotest').output.open { enter = true }
    end, { desc = 'Test [o]utput' })

    vim.keymap.set('n', '<leader>up', function()
      require('neotest').output_panel.toggle()
    end, { desc = 'Toggle [p]anel' })
  end,
}
