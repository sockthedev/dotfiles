local u = require("utils.keymaps")

local plugins = {
  {
    "tpope/vim-fugitive",
    config = function()
      u.set_keymaps("n", {
        { "<leader>gf", "<cmd>tab +Git<cr>", "Open Fugitive" },
      })
    end,
  },
}

return plugins
