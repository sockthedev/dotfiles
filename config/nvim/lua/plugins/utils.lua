return {
  -- global find/replace
  {
    'windwp/nvim-spectre',
    config = function()
      require('spectre').setup {
        is_open_target_win = false,
        is_close = true,
      }
      vim.keymap.set(
        'n',
        '<leader>fa',
        "<cmd>lua require('spectre').open({ is_insert_mode = true })<cr>",
        { desc = '[a]ll files' }
      )
      vim.keymap.set(
        'n',
        '<leader>fw',
        "<cmd>lua require('spectre').open({select_word=true})<cr>",
        { desc = 'Replace [w]ord in all files' }
      )
      vim.keymap.set(
        'n',
        '<leader>fc',
        "<cmd>lua require('spectre').open_file_search({ is_insert_mode = true })<cr>",
        { desc = '[c]urrent file' }
      )
      vim.keymap.set(
        'n',
        '<leader>ff',
        "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>",
        { desc = 'Replace word current [f]ile' }
      )
    end,
  },

  -- make screenshots of code
  {
    'mistricky/codesnap.nvim',
    build = 'make',
    cmd = 'CodeSnap',
    keys = {
      { '<leader>cp', '<cmd>CodeSnap<cr>', mode = 'x', desc = '[P]hoto' },
    },
    opts = {
      has_breadcrumbs = false,
      code_font_family = 'Berkeley Mono',
      bg_color = '#cccccc', -- transparent
      watermark = '',
      mac_window_bar = false,
    },
  },

  -- session management
  {
    'folke/persistence.nvim',
    config = function()
      require('persistence').setup { options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help' } }

      vim.keymap.set('n', '<leader>sr', function()
        require('persistence').load()
      end, { desc = '[r]estore session' })

      vim.keymap.set('n', '<leader>ss', function()
        require('persistence').select()
      end, { desc = '[s]elect session' })

      vim.keymap.set('n', '<leader>sd', function()
        require('persistence').stop()
      end, { desc = '[d]isable session saving' })

      -- load the last session
      vim.keymap.set('n', '<leader>sl', function()
        require('persistence').load { last = true }
      end, { desc = 'restore [l]ast session' })
    end,
  },

  -- Zen mode focus on a single pane
  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        backdrop = 1,
        width = 1, -- 100%
        height = 1, -- 100%
        options = {
          signcolumn = 'yes',
          number = true,
          relativenumber = true,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = '0',
        },
      },
    },
    keys = {
      { '<leader>z', '<cmd>ZenMode<cr>', desc = 'Zen Mode' },
    },
  },

  -- Highlights todo, notes, etc in comments
  -- NOTE: note
  -- WARN: warning
  -- ERROR: error
  -- TODO: todo
  -- FIX: fix
  -- HACK: hack
  -- TEST: test
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- Enables navigation between splits with support for wezterm pane navigation
  {
    lazy = false,
    'mrjones2014/smart-splits.nvim',
    config = function()
      local splits = require 'smart-splits'
      splits.setup {
        wezterm = true,
      }

      -- navigate splits
      vim.keymap.set('n', '<C-h>', splits.move_cursor_left)
      vim.keymap.set('n', '<C-j>', splits.move_cursor_down)
      vim.keymap.set('n', '<C-k>', splits.move_cursor_up)
      vim.keymap.set('n', '<C-l>', splits.move_cursor_right)
      vim.keymap.set('n', '<C-\\>', splits.move_cursor_previous)

      -- resize splits
      vim.keymap.set('n', '<C-A-h>', require('smart-splits').resize_left)
      vim.keymap.set('n', '<C-A-j>', require('smart-splits').resize_down)
      vim.keymap.set('n', '<C-A-k>', require('smart-splits').resize_up)
      vim.keymap.set('n', '<C-A-l>', require('smart-splits').resize_right)
    end,
  },

  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
  },

  -- Shows color inline for the various colour codes
  {
    'uga-rosa/ccc.nvim',
    config = function()
      require('ccc').setup {
        highlighter = {
          auto_enable = true,
          lsp = true,
          filetypes = {
            'css',
            -- 'tailwind',
            'typescript',
            'typescriptreact',
            'html',
          },
        },
      }
    end,
  },

  -- Code Folding
  -- NOTE: This requires some extra config in the LSP
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    init = function()
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      local fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' ↕ %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'UfoFoldedMoreMsg' })
        return newVirtText
      end

      ---@diagnostic disable-next-line: missing-fields
      require('ufo').setup {
        fold_virt_text_handler = fold_virt_text_handler,
        -- We are using the LSP based config, with the capability enabled
      }

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = 'Open folds except kinds' })
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = 'Close folds with' })
      vim.keymap.set('n', 'zK', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = 'Peek folded lines under cursor' })
    end,
  },
}
