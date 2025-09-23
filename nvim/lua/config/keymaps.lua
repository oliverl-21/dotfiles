-- This file is automatically loaded by lazyvim.config.init
local Util = require 'lazyvim.util'

local keymap = vim.keymap

-- Indenting
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')

-- Comments
vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', { noremap = false })
vim.api.nvim_set_keymap('', '<C-_>', 'gcc', { noremap = false })

-- Move Line Up/Down in Visual Mode
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.api.nvim_create_user_command('W', function()
  vim.cmd 'w !sudo tee % > /dev/null'
end, {})

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
--vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Diagnostic keymaps
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
