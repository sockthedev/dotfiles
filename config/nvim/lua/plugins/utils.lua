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
        '<leader>sss',
        "<cmd>lua require('spectre').open({ is_insert_mode = true })<cr>",
        { desc = 'Search in files' }
      )

      vim.keymap.set(
        'n',
        '<leader>ssr',
        "<cmd>lua require('spectre').open({select_word=true})<cr>",
        { desc = 'Replace current word in files' }
      )
      vim.keymap.set(
        'v',
        '<leader>ssr',
        "<cmd>lua require('spectre').open({select_word=true})<cr>",
        { desc = 'Replace current word in files' }
      )

      vim.keymap.set(
        'n',
        '<leader>ssb',
        "<cmd>lua require('spectre').open_file_search({ is_insert_mode = true })<cr>",
        { desc = 'Search in current file' }
      )
      vim.keymap.set(
        'n',
        '<leader>ssw',
        "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>",
        { desc = 'Replace current word in current file' }
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
      bg_color = '#00000000', -- transparent
      watermark = '',
      mac_window_bar = false,
    },
  },

  -- session management
  {
    'folke/persistence.nvim',
    config = function()
      require('persistence').setup { options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help' } }

      vim.keymap.set('n', '<leader>pl', "<cmd>lua require('persistence').load()<cr>", { desc = 'Restore Session' })

      vim.keymap.set(
        'n',
        '<leader>pd',
        "<cmd>lua require('persistence').stop()<cr>",
        { desc = "Don't Save Current Session" }
      )
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

  -- Navigate across tmux and nvim panes seamlessly with <C-hjkl>
  -- NOTE: This requires a sister configuration in tmux
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
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
        table.insert(newVirtText, { suffix, 'MoreMsg' })
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
