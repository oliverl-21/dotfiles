-- You can add your own plugins here or in other files in this directory!
-- I promise not to create any merge conflicts in this directory :)
-- See the kickstart.nvim README for more information
vim.wo.relativenumber = true
vim.keymap.set('n', '<C-b>', '<Cmd>Neotree toggle<CR>')
vim.api.nvim_create_user_command('W', function()
    vim.cmd("w !sudo tee % > /dev/null")
end, {})
return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("custom.indent")
        end,
    },
    "onsails/lspkind.nvim",
}
