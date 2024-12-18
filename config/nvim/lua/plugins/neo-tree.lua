return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      {
        's1n7ax/nvim-window-picker',
        name = 'window-picker',
        event = 'VeryLazy',
        version = '2.*',
        config = function()
          require('window-picker').setup {
            selection_chars = 'fjdksla;cmrueiwoqp',
          }
        end,
      },
    },
    config = function()
      require('neo-tree').setup {
        popup_border_style = 'single',
        enable_git_status = false,
        enable_diagnostics = false,
        default_component_configs = {
          file_size = { enabled = false },
          type = { enabled = false },
          last_modified = { enabled = false },
          created = { enabled = false },
        },
        filesystem = {
          filtered_items = {
            visible = true,
          },
        },
      }

      vim.keymap.set('n', 'tr', ':Neotree position=current<CR>', { silent = true, desc = 'File Tree Root' })
      vim.keymap.set(
        'n',
        'tt',
        ':Neotree reveal=true position=current<CR>',
        { silent = true, desc = 'File Tree current file' }
      )
      vim.keymap.set(
        'n',
        'tv',
        ':vsplit<CR>:Neotree reveal=true position=current<CR>',
        { silent = true, desc = 'File Tree current file vertical split' }
      )
    end,
  },
}
