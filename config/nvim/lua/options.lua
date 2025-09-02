-- Global settings
vim.o.compatible = false
vim.o.hidden = true
vim.o.autoread = true
vim.o.visualbell = false
vim.o.ttyfast = true
vim.o.number = true
vim.o.history = 1000
vim.o.mouse = 'a'

-- Suffixes : these are the files we are unlikely to edit
vim.o.suffixes = '.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.out,.toc,.gcda,.gcno'

-- tags file location
vim.o.tags = '.git/tags,.hg/tags,./tags;'

vim.o.background = 'dark'
vim.o.syntax = 'enable'

vim.o.ruler = true
vim.o.textwidth = 0
vim.o.backspace = 'indent,eol,start'
vim.o.showmatch = true
vim.o.showmode = true
vim.o.showcmd = true
vim.o.signcolumn = 'yes'
vim.o.startofline = false
vim.o.laststatus = 2

-- Default indentation and coding style
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true

-- Search setting
vim.o.incsearch = true
vim.o.smartcase = true
vim.o.infercase = true
vim.o.hlsearch = true
vim.o.showfulltag = true

-- Scrolling
vim.o.scrolloff = 3
vim.o.sidescrolloff = 2

-- Copy in both unnamed (*) and selection (+) clipboards
vim.opt.clipboard = 'unnamed,unnamedplus'
