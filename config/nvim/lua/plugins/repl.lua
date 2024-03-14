return {
  -- repl
  {
    'michaelb/sniprun',
    build = 'bash ./install.sh',
    config = function()
      require('sniprun').setup {
        selected_interpreters = { 'JS_TS_deno' },
        repl_enable = { 'JS_TS_deno' },
        live_mode_toggle = 'enable',
        live_display = { 'Terminal' },
        display = { 'Terminal' },
      }
    end,
  },
}
