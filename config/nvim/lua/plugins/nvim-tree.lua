return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      -- recommended settings from nvim-tree documentation
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- configure nvim-tree
      local base_config = {
        sort_by = 'case_sensitive',
        hijack_directories = {
          enable = false,
        },
        update_focused_file = {
          enable = true,
        },
        view = {
          cursorline = false,
          side = 'right',
          preserve_window_proportions = false,
          number = true,
          relativenumber = true,
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        renderer = {
          root_folder_label = false,
          root_folder_modifier = ':t',
          icons = {
            show = {
              file = false,
              folder = false,
              folder_arrow = false,
              git = false,
            },
            git_placement = 'after',
          },
        },
        filters = {
          dotfiles = false,
          custom = { '^.git$' },
        },
        diagnostics = {
          enable = false,
        },
      }

      local function toggle_nvim_tree_float()
        local height = vim.o.lines - 20
        local width = 120
        local config = vim.deepcopy(base_config)
        config.view.side = 'right'
        config.view.float = {
          enable = true,
          open_win_config = {
            relative = 'editor',
            border = 'single',
            width = width,
            height = height,
            row = (vim.o.lines - height) / 2 - 2, -- Center vertically
            col = (vim.o.columns - width) / 2, -- Center horizontally
          },
        }
        require('nvim-tree').setup(config)
        require('nvim-tree.api').tree.toggle { focus = true }
      end

      local function toggle_nvim_tree_fixed()
        local config = vim.deepcopy(base_config)
        config.view.float = {
          enable = false,
        }
        config.view.viewport_ratios = nil
        config.view.side = 'right'
        config.view.width = {
          min = 70,
          max = 70,
        }
        require('nvim-tree').setup(config)
        require('nvim-tree.api').tree.toggle { focus = false }
      end

      -- keymaps
      vim.keymap.set('n', 'tt', toggle_nvim_tree_float, { silent = true, desc = 'Toggle Float' })
      vim.keymap.set('n', 'tr', toggle_nvim_tree_fixed, { silent = true, desc = 'Toggle Fixed' })
      vim.keymap.set('n', 'tf', ':NvimTreeFocus<CR>', { silent = true, desc = 'Focus' })
      vim.keymap.set('n', 'tc', ':NvimTreeClose<CR>', { silent = true, desc = 'Close Tree' })
    end,
  },
}
