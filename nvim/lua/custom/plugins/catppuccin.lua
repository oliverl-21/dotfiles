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
            term_colors = false,
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
    end,
}
-- vim: ts=2 sts=2 sw=2 et
