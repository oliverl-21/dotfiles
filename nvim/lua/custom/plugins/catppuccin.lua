return { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            integrations = {
                cmp = true,
                gitsigns = true,
                neotree = true,
                treesitter = true,
                notify = false,
                mini = false,
            },
            color_overrides = {
                all = {
                    text = "#ffffff",
                },
                latte = {
                    base = "#ff0000",
                    mantle = "#242424",
                    crust = "#474747",
                },
                frappe = {},
                macchiato = {},
                mocha = {},
            }
        })
        vim.cmd.colorscheme "catppuccin"
        local latte = require("catppuccin.palettes").get_palette "latte"
        local frappe = require("catppuccin.palettes").get_palette "frappe"
        local macchiato = require("catppuccin.palettes").get_palette "macchiato"
        local mocha = require("catppuccin.palettes").get_palette "mocha"
    end,
    }
