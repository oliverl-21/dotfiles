return {
  'pmizio/typescript-tools.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  config = function()
    local api = require 'typescript-tools.api'
    require('typescript-tools').setup {
      handlers = {
        ['textDocument/publishDiagnostics'] = api.filter_diagnostics { 80006 }, -- Ignore 'This may be converted to an async function' diagnostics.
      },
      settings = {
        tsserver_plugins = {
          '@styled/typescript-styled-plugin',
        },
      },
    }
  end,
}
