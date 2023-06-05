return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true, presets = { operators = false } },
    window = {
      border = "single",
      position = "bottom",
      padding = { 1, 0, 1, 0 },
      margin = { 0, 0, 0, 0 },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register({
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["gz"] = { name = "+surround" },
      ["t"] = { name = "+tree" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader><tab>"] = { name = "+tabs" },
      ["<leader>a"] = { name = "+ai" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>cm"] = { name = "+markdown" },
      ["<leader>d"] = { name = "+dap" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>gd"] = { name = "+diff" },
      ["<leader>gh"] = { name = "+hunks" },
      ["<leader>h"] = { name = "+harpoon" },
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>t"] = { name = "+test" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>w"] = { name = "+windows" },
      ["<leader>x"] = { name = "+diagnostics" },
    })
  end,
}
