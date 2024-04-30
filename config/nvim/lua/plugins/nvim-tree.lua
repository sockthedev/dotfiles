return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      -- recommended settings from nvim-tree documentation
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- configure nvim-tree
      local base_nvim_tree_config = {
        sort_by = 'case_sensitive',
        hijack_directories = {
          enable = false,
        },
        update_focused_file = {
          enable = true,
        },
        view = {
          cursorline = false,
          side = 'left',
          preserve_window_proportions = true,
          number = true,
          relativenumber = true,
          float = {
            enable = true,
            open_win_config = function()
              local height = vim.o.lines - 6
              local width = 70

              return {
                relative = 'editor',
                border = 'single',
                width = width,
                height = height,
                row = (vim.o.lines - height) / 2 - 2, -- Center vertically
                col = (vim.o.columns - width) / 2, -- Center horizontally
              }
            end,
          },
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
        base_nvim_tree_config.view.float.enable = true
        base_nvim_tree_config.view.side = 'right'
        require('nvim-tree').setup(base_nvim_tree_config)
        require('nvim-tree.api').tree.toggle { focus = true }
      end

      local function toggle_nvim_tree_fixed()
        base_nvim_tree_config.view.float.enable = false
        base_nvim_tree_config.view.viewport_ratios = nil -- Reset specific float settings if needed
        base_nvim_tree_config.view.side = 'right'
        base_nvim_tree_config.view.width = {
          min = 70,
          max = 70,
        }
        require('nvim-tree').setup(base_nvim_tree_config)
        require('nvim-tree.api').tree.toggle { focus = true }
      end

      -- keymaps
      vim.keymap.set('n', 'tt', toggle_nvim_tree_float, { silent = true, desc = 'Toggle Float' })
      vim.keymap.set('n', 'tr', toggle_nvim_tree_fixed, { silent = true, desc = 'Toggle Fixed' })
      -- vim.keymap.set('n', 'tt', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggle' })
      -- vim.keymap.set('n', 'tf', ':NvimTreeFocus<CR>', { silent = true, desc = 'Focus' })
    end,
  },
}
