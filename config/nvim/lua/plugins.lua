-- Use :lua vim.pack.update() to update the plugins
vim.pack.add({
    -- Colorcheme and UI
    { src = "https://github.com/neozenith/estilo-xoria256" },
    { src = "https://github.com/itchyny/lightline.vim.git" },
    { src = "https://github.com/Bekaboo/deadcolumn.nvim" },

    -- tpope's goodness
    { src = "https://github.com/tpope/vim-fugitive.git" },
    { src = "https://github.com/tpope/vim-rhubarb.git" },
    { src = "https://github.com/tpope/vim-sleuth" },
    { src = "https://github.com/tpope/vim-surround.git" },

    -- Navigation and fuzzy finders
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },

    -- Highlighting and completion
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },

    -- Outliner
    { src = "https://github.com/vimoutliner/vimoutliner.git" },

    -- LSP-related
    { src = "https://github.com/neovim/nvim-lspconfig.git" },
    { src = "https://github.com/mason-org/mason.nvim.git" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },

    -- Copilot-related
    { src = "https://github.com/zbirenbaum/copilot.lua.git" },
    { src = "https://github.com/CopilotC-Nvim/CopilotChat.nvim" },
    { src = "https://github.com/zbirenbaum/copilot-cmp.git" },
})

-- colorscheme
vim.cmd.colorscheme 'xoria256'
vim.g.lightline = { colorscheme = 'xoria256' }

-- oil
require('oil').setup({
    win_options = {
        -- Find the available highlight groups with `:Telescope highlights`
        winbar = "%#@comment#%{substitute(v:lua.require('oil').get_current_dir(), '^' . $HOME, '~', '')}",
    }
})

-- telescope
require('telescope').setup({
    pickers = {
        git_files = {
            theme = 'ivy',
        },
        find_files = {
            theme = 'ivy',
        },
        live_grep = {
            theme = 'ivy',
        },
    },
})

-- treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'c', 'cpp', 'python', 'lua', 'bash', 'make', 'cmake', 'devicetree',
        'bitbake', 'markdown'
    },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- LSP
require('mason').setup()
require('mason-lspconfig').setup {
    ensure_installed = { 'clangd', 'pyright', 'lua_ls' },
    automatic_enable = true,
}

local cmp_lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').clangd.setup {
    -- nvim-cmp almost supports LSP's capabilities so advertise it to LSP servers.
    capabilities = cmp_lsp_capabilities
}

-- Completion
local cmp = require('cmp')
require('cmp').setup {
    sources = {
      { name = 'copilot' },
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    },
    completion = {
        -- Disable automatic autocomplete
        autocomplete = false
    }
}

-- Copilot completion
-- It is recommended to disable copilot.lua's suggestion and panel modules,
-- as they can interfere with completions properly appearing in copilot-cmp.
require('copilot_cmp').setup()
require('copilot').setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
})

-- Copilot chat
require('CopilotChat').setup()
