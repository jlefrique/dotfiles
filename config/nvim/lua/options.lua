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

-- Nice statusbar
vim.o.laststatus = 2
vim.o.statusline = table.concat({
    "%#@variable#",                           -- highlight group
    "%-3.3n",                                 -- buffer number
    "%f",                                     -- file name
    "%h%m%r%w",                               -- flags
    "[%{strlen(&ft)?&ft:'none'},",            -- filetype
    "%{&encoding},",                          -- encoding
    "%{&fileformat}]",                        -- file format
    --"%{FugitiveStatusline()}",              -- fugitive status
    "%=",                                     -- right align
    "0x%-8B",                                 -- current char
    "%-14.(%l,%c%V%) %<%P"                    -- offset
}, " ")

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
vim.o.clipboard = 'unnamed,unnamedplus'

-- Highlight 80th column
vim.o.colorcolumn = '80'

-- Tab complete menu
vim.o.wildmode = 'longest:full'
vim.o.wildmenu = true
vim.o.wildignore ='*.o,*.a,*.so,*.ko,*~,*.swp,*.pyc,*.dll,tags,*.o.*,.git/,.hg/,.svn/'


-- Grep programs
if vim.fn.executable("rg") == 1 then
    -- rg already excludes files ignored by the VCS, it's enough
    vim.o.grepprg = "rg --vimgrep"
    vim.o.grepformat = "%f:%l:%c:%m"

elseif vim.fn.system('git rev-parse --is-inside-work-tree'):match('true') then
    -- git grep only searches in tracked files
    vim.o.grepprg = "git grep -n -I $*"
    vim.o.grepformat = "%f:%l:%m"
else
    -- Exclude all the files from wildignore
    local wildignore = vim.o.wildignore
    local exclude_args = ""
    for pattern in string.gmatch(wildignore, "[^,]+") do
        exclude_args = exclude_args .. " --exclude=" .. vim.fn.shellescape(pattern)
    end
    vim.o.grepprg = "grep -n -R -I" .. exclude_args .. " $*"
    vim.o.grepformat = "%f:%l:%m,%f:%l%m,%f  %l%m"
end

-- Set ft=log
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.log", "messages", "messages.*"},
    callback = function()
        vim.bo.filetype = "log"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    callback = function()
        vim.bo.formatprg = "jq"
    end,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.conf"},
    callback = function()
        vim.bo.filetype = "config"
    end,
})
