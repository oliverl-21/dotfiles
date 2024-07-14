return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
    require('which-key').add {
      { '<leader>c', group = '[C]ode' },
      { '', desc = '<leader>c_', hidden = true },
      { '<leader>d', group = '[D]ocument' },
      { '', desc = '<leader>d_', hidden = true },
      { '<leader>g', group = '[G]it' },
      { '', desc = '<leader>g_', hidden = true },
      { '<leader>r', group = '[R]ename' },
      { '', desc = '<leader>r_', hidden = true },
      { '<leader>s', group = '[S]earch' },
      { '', desc = '<leader>s_', hidden = true },
      { '<leader>w', group = '[W]orkspace' },
      { '', desc = '<leader>w_', hidden = true },
    }
  end,
  opts = {
    mode = 'n', -- NORMAL mode
    -- prefix: use "<leader>f" for example for mapping everything related to finding files
    -- the prefix is prepended to every mapping part of `mappings`
    prefix = ' ',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
    expr = false, -- use `expr` when creating keymaps
  },
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}
