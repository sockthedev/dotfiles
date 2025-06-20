return {
  -- cursor movement animation
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      cursor_color = '#ffffff',
      stiffness = 0.8, -- 0.6      [0, 1]
      trailing_stiffness = 0.5, -- 0.3      [0, 1]
      distance_stop_animating = 0.5, -- 0.1      > 0
      hide_target_hack = false, -- true     boolean
    },
  },

  -- icons
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      local lackluster = require 'lackluster'
      require('nvim-web-devicons').setup {
        default = true,
        strict = true,
        color_icons = false,
        override = {
          ['default_icon'] = {
            color = lackluster.color.gray4,
            name = 'Default',
          },
        },
      }
    end,
  },

  -- render markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      file_types = { 'markdown', 'Avante' },
      sign = {
        enabled = false,
      },
    },
    ft = { 'markdown', 'Avante' },
  },

  -- global find/replace
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup {}
      vim.keymap.set('n', '<leader>ff', ":lua require('grug-far').open()<cr>", { desc = '[f]ind' })
      vim.keymap.set(
        'n',
        '<leader>fw',
        ":lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })<cr>",
        { desc = 'find [w]ord' }
      )
      vim.keymap.set(
        'v',
        '<leader>ff',
        ":<C-u>lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand('%') } })<cr>",
        { desc = '[f]ind selection' }
      )
      vim.keymap.set(
        'n',
        '<leader>fc',
        ":lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<cr>",
        { desc = 'find in [c]urrent file' }
      )
    end,
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

  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
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
