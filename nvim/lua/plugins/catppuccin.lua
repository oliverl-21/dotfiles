return {
  'catppuccin/nvim',
  lazy = false,
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      highlight_overrides = {
        all = function(colors)
          return {
            NvimTreeNormal = { fg = colors.none },
            CmpBorder = { fg = '#3e4145' },
          }
        end,
        latte = function(latte)
          return {
            Normal = { fg = latte.base },
          }
        end,
        frappe = function(frappe)
          return {
            ['@comment'] = { fg = frappe.surface2, style = { 'italic' } },
          }
        end,
        macchiato = function(macchiato)
          return {
            LineNr = { fg = macchiato.overlay1 },
          }
        end,
        mocha = function(mocha)
          return {
            Comment = { fg = mocha.flamingo },
          }
        end,
      },
      flavour = 'mocha',
      integrations = {
        cmp = true,
        mason = true,
        gitsigns = true,
        neotree = true,
        treesitter = true,
        which_key = true,
        noice = true,
        indent_blankline = {
          enabled = true,
          scope_color = 'flamingo', -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = true,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        lsp_trouble = true,
      },
      term_colors = false,
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
-- vim: ts=2 sts=2 sw=2 et
