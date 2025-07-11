return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
  root_markers = { '.git' },
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
      validate = true,
      format = {
        enable = true,
      },
      hover = true,
      completion = true,
    },
  },
}
