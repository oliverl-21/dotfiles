return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  lazy = true,
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
    local navic = require 'nvim-navic'

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      if _.server_capabilities.documentSymbolProvider then
        navic.attach(_, bufnr)
      end
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end
    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- used to enable autocompletion (assign to every lsp server config)
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    -- document existing key chains
    local servers = {
      pylsp = {},
      jsonls = {},
      html = { filetypes = { 'html', 'twig', 'hbs' } },
      tflint = {},
      terraformls = {},
      tsserver = { filetypes = { 'nofile' }, autostart = false },
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
