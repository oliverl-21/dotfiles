vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.hjson', '*.hujson' },
  command = 'setfiletype jsonc',
})
