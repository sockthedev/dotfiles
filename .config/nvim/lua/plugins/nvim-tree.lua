return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- configure nvim-tree
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      hijack_directories = {
        enable = false,
      },
      update_focused_file = {
        enable = true,
        update_cwd = false,
      },
      view = {
        adaptive_size = false,
        side = "left",
        width = 45,
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      renderer = {
        root_folder_label = false,
        root_folder_modifier = ":t",
        icons = {
          git_placement = "after",
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "S",
              unmerged = "",
              renamed = "➜",
              untracked = "U",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { "^.git$" },
        no_buffer = false,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
    })

    -- keymaps
    vim.keymap.set("n", "tt", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle" })
  end,
}
