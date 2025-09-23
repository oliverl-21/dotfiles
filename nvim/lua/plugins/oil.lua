return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    columns = {
      'icon',
      'permissions',
      'size',
      'mtime',
    },
    view_options = {
      show_hidden = true,
    },
  },

  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  vim.keymap.set('n', '<leader>e', '<CMD>Oil --float .<CR>', { desc = 'Open Oil floatin current directory' }),
  vim.keymap.set('n', '<leader>b', "<CMD>lua require('oil').open_float()<CR>", { desc = 'toggle Oil' }),
}
