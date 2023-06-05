return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("harpoon").setup({
      tabline = false,
      tabline_prefix = "   ",
      tabline_suffix = "   ",
    })

    vim.keymap.set("n", "<C-M-j>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = "Toggle" })
    vim.keymap.set("n", "<C-M-k>", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "Add file" })

    vim.keymap.set("n", "<C-M-l>", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = "Go next" })
    vim.keymap.set("n", "<C-M-h>", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { desc = "Go prev" })

    vim.keymap.set("n", "<C-M-1>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "Go 1", noremap = true })
    vim.keymap.set("n", "<C-M-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = "Go 2", noremap = true })
    vim.keymap.set("n", "<C-M-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = "Go 3", noremap = true })
    vim.keymap.set("n", "<C-M-4>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { desc = "Go 4", noremap = true })
    vim.keymap.set("n", "<C-M-5>", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", { desc = "Go 5", noremap = true })
    vim.keymap.set("n", "<C-M-6>", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", { desc = "Go 6", noremap = true })
    vim.keymap.set("n", "<C-M-7>", "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", { desc = "Go 7", noremap = true })
    vim.keymap.set("n", "<C-M-8>", "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", { desc = "Go 8", noremap = true })
    vim.keymap.set("n", "<C-M-9>", "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", { desc = "Go 9", noremap = true })
    vim.keymap.set(
      "n",
      "<C-M-0>",
      "<cmd>lua require('harpoon.ui').nav_file(10)<cr>",
      { desc = "Go 10", noremap = true }
    )
  end,
}
