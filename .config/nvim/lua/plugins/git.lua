local u = require("utils.keymaps")

local plugins = {
  {
    "tpope/vim-fugitive",
    config = function()
      u.set_keymaps("n", {
        { "<leader>gf", vim.cmd.Git, "Open Fugitive" },
      })
    end,
  },
}

return plugins
