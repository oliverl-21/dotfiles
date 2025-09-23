return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  lazy = true,
  dependencies = {
    { 'antosha417/nvim-lsp-file-operations', config = true },
    'mason-org/mason-lspconfig.nvim',
    { 'folke/lazydev.nvim', opts = {} },
    'saghen/blink.cmp',
  },
  config = function()
    require('lazydev').setup {
      -- add any options here, or leave empty to use the default settings
    }
    -- import lspconfig plugin
    local mason_lspconfig = require 'mason-lspconfig'
    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    -- document existing key chains
    local servers = {
      html = { filetypes = { 'html', 'twig', 'hbs' } },
      yamlls = {
        yaml = {
          schemas = { ['https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/master-standalone-strict/all.json'] = '/*.k8s.yaml' },
        },
      },
      ansiblels = {
        filetypes = { 'yaml.ansible' },
        single_file_support = false,
        ansible = {
          python = {
            interpreterPath = '/Users/oliver/Documents/code/ansible/bin/python3',
          },
          completion = {
            provideRedirectModules = true,
            provideModuleOptionAliases = true,
          },
        },
      },
    }

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }
  end,
}
