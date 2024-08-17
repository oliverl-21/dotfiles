vim.filetype.add { extension = { j2 = 'jinja' } }
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.j2', '*.jinja2', '*.j2' },
  command = 'setfiletype jinja',
})
