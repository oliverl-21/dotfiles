return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
    'williamboman/mason-lspconfig.nvim',
    { 'folke/neodev.nvim', opts = {} },
    { 'folke/neoconf.nvim', cmd = 'Neoconf' },
  },
  config = function()
    require('neoconf').setup {
      -- override any of the default settings here
    }
    -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
    require('neodev').setup {
      -- add any options here, or leave empty to use the default settings
    }
    -- import lspconfig plugin
    local lspconfig = require 'lspconfig'
    local mason_lspconfig = require 'mason-lspconfig'

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      -- set keybinds
      opts.desc = 'Show LSP references'
      keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

      opts.desc = 'Go to declaration'
      keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = 'Show LSP definitions'
      keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions

      opts.desc = 'Show LSP implementations'
      keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts) -- show lsp implementations

      opts.desc = 'Show LSP type definitions'
      keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts) -- show lsp type definitions

      opts.desc = 'See available code actions'
      keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = 'Smart rename'
      keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = 'Show buffer diagnostics'
      keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- show  diagnostics for file

      opts.desc = 'Show line diagnostics'
      keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = 'Go to previous diagnostic'
      keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = 'Go to next diagnostic'
      keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = 'Show documentation for what is under cursor'
      keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = 'Signature Documentation'
      keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

      opts.desc = 'Restart LSP'
      keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary
    end

    local servers = {
      pyright = {},
      html = { filetypes = { 'html', 'twig', 'hbs' } },
      tflint = {},
      terraformls = {},
      ansiblels = {
        filetypes = { 'yaml', 'yaml.ansible' },
        Ansible = {
          python = {
            interpreterPath = '/Users/oliver/Documents/code/ansible/bin/python3',
          },
        },
      },
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    }

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- used to enable autocompletion (assign to every lsp server config)
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    mason_lspconfig.setup_handlers {
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end,
    }

    lspconfig['bashls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { 'sh' },
      settings = {
        bashIde = {
          globPattern = '*@(.sh|.inc|.bash|.command)',
          backgroundAnalysisMaxFiles = 500,
          enableSourceErrorDiagnostics = true,
          explainshellEndpoint = '',
          includeAllWorkspaceSymbols = true,
          logLevel = 'info',
          shellcheckArguments = '',
          shellcheckPath = 'shellcheck',
        },
      },
    }
  end,
}
