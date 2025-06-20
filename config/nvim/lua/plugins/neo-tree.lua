return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'folke/snacks.nvim',
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
      local Snacks = require 'snacks'

      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end

      local function copy_path(state)
        -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
        -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local results = {
          modify(filepath, ':.'),
          filepath,
          filename,
          modify(filename, ':r'),
        }

        vim.ui.select({
          '1. ' .. results[1],
          '2. ' .. results[2],
          '3. ' .. results[3],
          '4. ' .. results[4],
        }, { prompt = 'Choose path to copy to clipboard:' }, function(choice)
          if choice then
            local i = tonumber(choice:sub(1, 1))
            if i then
              local result = results[i]
              vim.fn.setreg('+', result)
              vim.notify('Copied to clipboard: ' .. result)
            else
              vim.notify 'Invalid selection'
            end
          else
            vim.notify 'Selection cancelled'
          end
        end)
      end

      local events = require 'neo-tree.events'

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
        window = {
          mappings = {
            ['Y'] = copy_path,
          },
        },
        event_handlers = {
          { event = events.FILE_MOVED, handler = on_move },
          { event = events.FILE_RENAMED, handler = on_move },
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
