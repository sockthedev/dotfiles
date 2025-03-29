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

      -- Sets vim.ui.select to telescope
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Pretty icons
      { 'nvim-tree/nvim-web-devicons' },

      -- Visualize your undo tree and fuzzy-search changes in it.
      'debugloop/telescope-undo.nvim',

      -- Open and preview the current file at any previous commit
      {
        'isak102/telescope-git-file-history.nvim',
        dependencies = {
          'nvim-lua/plenary.nvim',
          'tpope/vim-fugitive',
        },
      },
    },
    config = function()
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?

      local open_with_trouble = require('trouble.sources.telescope').open

      local gfh_actions = require('telescope').extensions.git_file_history.actions

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
          file_ignore_patterns = {
            '^.git/',
            'node_modules/*',
          },
          -- We override the ripgrep arguments to include hidden files and ignore files in .git directory
          -- vimgrep_arguments = {
          --   'rg',
          --   '--color=never',
          --   '--no-heading',
          --   '--with-filename',
          --   '--line-number',
          --   '--column',
          --   '--smart-case',
          --   '--hidden', -- Include hidden files
          -- },
        },
        pickers = {
          find_files = {
            hidden = true, -- Include hidden files when searching for files
          },
          git_files = {
            hidden = true, -- Include hidden files when searching for files
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          fzf = {},
          git_file_history = {
            -- Keymaps inside the picker
            mappings = {
              i = {
                ['<C-g>'] = gfh_actions.open_in_browser,
              },
              n = {
                ['<C-g>'] = gfh_actions.open_in_browser,
              },
            },

            -- The command to use for opening the browser (nil or string)
            -- If nil, it will check if xdg-open, open, start, wslview are available, in that order.
            browser_command = nil,
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'undo')
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'git_file_history')

      -- NOTE: There are other Telescope key mappings in other files, like the LSP.

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>td', builtin.diagnostics, { desc = '[d]iagnostics' })
      vim.keymap.set('n', '<leader>ta', builtin.find_files, { desc = '[a]ll files' })
      vim.keymap.set('n', '<leader>tb', function()
        require('telescope').extensions.git_file_history.git_file_history()
      end, { desc = '[b]lame' })
      vim.keymap.set('n', '<leader>tf', builtin.find_files, { desc = 'git [f]iles' })
      vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = '[g]rep' })
      vim.keymap.set('n', '<leader>th', builtin.help_tags, { desc = '[h]elp' })
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
