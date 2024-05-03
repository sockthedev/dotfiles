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
          side = 'right',
          preserve_window_proportions = false,
          number = true,
          relativenumber = true,
          float = {
            enable = true,
            open_win_config = function()
              local height = vim.o.lines - 20
              local width = 120
              if vim.o.columns < 120 then
                width = vim.o.columns - 20
              end
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
        require('nvim-tree.api').tree.toggle { focus = true }
      end

      -- keymaps
      vim.keymap.set('n', 'tt', toggle_nvim_tree_float, { silent = true, desc = 'Toggle Float' })
      vim.keymap.set('n', 'tf', ':NvimTreeFocus<CR>', { silent = true, desc = 'Focus' })
      vim.keymap.set('n', 'tc', ':NvimTreeClose<CR>', { silent = true, desc = 'Close Tree' })
    end,
  },
}
