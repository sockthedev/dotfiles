return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      -- recommended settings from nvim-tree documentation
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- configure nvim-tree
      require('nvim-tree').setup {
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
              return {
                relative = 'editor',
                width = 70,
                height = vim.o.lines - 2,
                border = 'none',
                row = 0,
                col = 0,
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

      -- keymaps
      vim.keymap.set('n', 'tt', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggle' })
      vim.keymap.set('n', 'tf', ':NvimTreeFocus<CR>', { silent = true, desc = 'Focus' })
    end,
  },
}
