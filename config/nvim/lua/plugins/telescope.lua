return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',

      -- Better search
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Pretty icons
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?

      local open_with_trouble = require('trouble.sources.telescope').open

      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<c-t>'] = open_with_trouble,
            },
            n = {
              ['<c-t>'] = open_with_trouble,
            },
          },
          layout_config = {
            horizontal = {
              width = 0.90,
              height = 0.90,
              preview_width = 0.5,
            },
          },
          -- We override the ripgrep arguments to include hidden files and ignore files in .git directory
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden', -- Include hidden files
          },
          file_ignore_patterns = { '^.git/' }, -- Ensure we always ignore the .git directory
        },
        pickers = {
          find_files = {
            hidden = true, -- Include hidden files when searching for files
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- NOTE: There are other Telescope key mappings in other files, like the LSP.

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>td', builtin.diagnostics, { desc = '[d]iagnostics' })
      vim.keymap.set('n', '<leader>tf', builtin.find_files, { desc = '[f]iles' })
      vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = '[g]rep' })
      vim.keymap.set('n', '<leader>th', builtin.help_tags, { desc = '[h]elp' })
      vim.keymap.set('n', '<leader>tk', builtin.keymaps, { desc = '[k]eymaps' })
      vim.keymap.set('n', '<leader>tr', builtin.resume, { desc = '[R]esume' })
      vim.keymap.set('n', '<leader>tt', builtin.builtin, { desc = 'choose [t]elescope type' })
      vim.keymap.set('n', '<leader>tw', builtin.grep_string, { desc = 'current [w]ord' })
      vim.keymap.set('n', '<leader>t.', builtin.oldfiles, { desc = 'Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>.', builtin.oldfiles, { desc = 'Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set(
        'n',
        '<leader>/',
        builtin.current_buffer_fuzzy_find,
        { desc = '[/] Fuzzily search in current buffer' }
      )

      vim.keymap.set('n', '<leader>t/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[/] in Open Files' })

      -- Shortcut for searching the neovim configuration files
      vim.keymap.set('n', '<leader>tn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[n]eovim files' })
    end,
  },
}
