return {
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
