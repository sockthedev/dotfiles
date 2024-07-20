return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup {
        custom_surroundings = {
          [')'] = { output = { left = '(', right = ')' } },
          [']'] = { output = { left = '[', right = ']' } },
        },
      }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local custom_fileinfo = function(args)
        local filetype = vim.bo.filetype
        -- Don't show anything if there is no filetype
        if filetype == '' then
          return ''
        end
        -- Construct output string if truncated or buffer is not normal
        if MiniStatusline.is_truncated(args.trunc_width) or vim.bo.buftype ~= '' then
          return filetype
        end
        -- Construct output string with extra file info
        local encoding = vim.bo.fileencoding or vim.bo.encoding
        return string.format('%s/%s', filetype, encoding)
      end

      local statusline = require 'mini.statusline'
      statusline.setup {
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
            local location = MiniStatusline.section_location { trunc_width = 75 }
            local fileinfo = custom_fileinfo { trunc_width = 20 }
            local search = MiniStatusline.section_searchcount { trunc_width = 75 }

            return MiniStatusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { '%.30F' } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = 'MiniStatuslineFileinfo', strings = { search, location } },
            }
          end,
          inactive = function()
            local fileinfo = custom_fileinfo { trunc_width = 20 }

            return MiniStatusline.combine_groups {
              { hl = 'MiniStatuslineFilename', strings = { filename = '%.30F' } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            }
          end,
        },
      }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}
