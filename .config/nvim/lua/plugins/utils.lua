local plugins = {
  -- repl
  {
    "michaelb/sniprun",
    build = "sh ./install.sh",
    config = function()
      require("sniprun").setup({
        selected_interpreters = { "JS_TS_deno" },
        repl_enable = { "JS_TS_deno" },
        display = {
          "Classic", --# display results in the command-line  area
          "VirtualText", --# display results as virtual text
          -- "VirtualTextOk", --# display ok results as virtual text (multiline is shortened)
          -- "TempFloatingWindow",      --# display results in a floating window
          -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
          -- "Terminal",                --# display results in a vertical split
          -- "TerminalWithCode",        --# display results and code history in a vertical split
          -- "NvimNotify",              --# display with the nvim-notify plugin
          -- "Api"                      --# return output to a programming interface
        },
      })
    end,
  },

  -- Heuristic buffer auto-close
  {
    "axkirillov/hbac.nvim",
    config = function()
      require("hbac").setup({
        autoclose = true, -- set autoclose to false if you want to close manually
        threshold = 10, -- hbac will start closing unedited buffers once that number is reached
      })
    end,
  },

  -- Vim motions game
  {
    "ThePrimeagen/vim-be-good",
  },

  -- Code comment generator
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    version = "*",
    config = function()
      require("neogen").setup({
        enabled = true,
      })
      local opts = { noremap = true, silent = true, desc = "Generate code comment" }
      vim.api.nvim_set_keymap("n", "<Leader>cc", ":lua require('neogen').generate()<CR>", opts)
    end,
  },

  -- TypeScript tsc validator
  {
    "dmmulroy/tsc.nvim",
    config = function()
      require("tsc").setup({
        flags = {
          -- Support typchecking across a monorepo
          build = true,
        },
      })

      vim.keymap.set("n", "<leader>xt", "<cmd>TSC<cr>", { desc = "TypeScript tsc" })
    end,
  },

  -- A lua based substitution
  {
    "chrisgrieser/nvim-alt-substitute",
    opts = true,
    event = "CmdlineEnter",
  },

  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
  },

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } } },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
    end,
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },

  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- highlight/navigate uses of  word under cursor using LSP, Tree-sitter, or regex matching
  {
    "rrethy/vim-illuminate",
    event = "BufReadPost",
    opts = {
      delay = 200,
      under_cursor = false, -- we dont want to highlight the word under cursor, only other instances
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
    -- stylua: ignore
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next word reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev word reference" },
    },
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
    },
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
    },
  },

  -- surround
  {
    "echasnovski/mini.surround",
    version = "*",
    keys = function(plugin, keys)
      -- Populate the keys based on the user's options
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      ---@diagnostic disable-next-line: missing-parameter
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      -- use gz mappings instead of s to prevent conflict with leap
      require("mini.surround").setup(opts)
    end,
  },

  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },

  -- auto tags
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Maximize window toggling
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>z", "<CMD>MaximizerToggle<CR>", desc = "Maximize Window", silent = true },
      {
        "<leader>z",
        "<CMD>MaximizerToggle<CR>gv",
        mode = "v",
        desc = "Maximize Window",
        silent = true,
      },
    },
    init = function()
      vim.g.maximizer_set_default_mapping = 0
    end,
  },
}

return plugins
