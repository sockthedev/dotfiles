return {
  'goolord/alpha-nvim',
  config = function()
    local dashboard = require 'alpha.themes.dashboard'

    dashboard.section.header.val = {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    }

    dashboard.section.buttons.val = {
      dashboard.button('f', ' ' .. ' Find file', ':Telescope find_files <CR>'),
      dashboard.button('n', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
      dashboard.button('g', ' ' .. ' Find text', ':Telescope live_grep <CR>'),
      dashboard.button('c', ' ' .. ' Config', ':e $MYVIMRC <CR>'),
      dashboard.button('s', '勒' .. ' Restore Session', [[:lua require("persistence").load() <cr>]]),
      dashboard.button('l', '鈴' .. ' Lazy', ':Lazy<CR>'),
      dashboard.button('q', ' ' .. ' Quit', ':qa<CR>'),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = 'AlphaButtons'
      button.opts.hl_shortcut = 'AlphaShortcut'
    end
    dashboard.section.footer.opts.hl = 'Type'
    dashboard.section.header.opts.hl = 'AlphaHeader'
    dashboard.section.buttons.opts.hl = 'AlphaButtons'
    dashboard.opts.layout[1].val = 8

    local function footer()
      return '🧦'
    end

    dashboard.section.footer.val = footer()

    require('alpha').setup(dashboard.opts)
  end,
}
