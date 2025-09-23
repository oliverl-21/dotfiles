local opt = vim.opt

-- Tab / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.cmdheight = 1
opt.scrolloff = 10
opt.completeopt = 'menuone,noselect'
opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

-- Behaviour
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.backspace = 'indent,eol,start'
opt.autochdir = false
opt.mouse = 'a'
opt.updatetime = 250
opt.timeoutlen = 500
