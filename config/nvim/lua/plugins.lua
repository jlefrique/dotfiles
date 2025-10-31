-- Use :lua vim.pack.update() to update the plugins
vim.pack.add({
    -- Colorcheme and UI
    { src = "https://github.com/neozenith/estilo-xoria256" },
    { src = "https://github.com/itchyny/lightline.vim.git" },

    -- tpope's goodness
    { src = "https://github.com/tpope/vim-fugitive.git" },
    { src = "https://github.com/tpope/vim-rhubarb.git" },
    { src = "https://github.com/tpope/vim-sleuth" },
    { src = "https://github.com/tpope/vim-surround.git" },

    -- Navigation and fuzzy finders
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },

    -- Highlighting
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/Bekaboo/deadcolumn.nvim" },
    { src = "https://github.com/ntpeters/vim-better-whitespace.git" },

    -- Completion
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },
    { src = "https://github.com/hrsh7th/cmp-path" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/zbirenbaum/copilot-cmp.git" },

    -- Outliner
    { src = "https://github.com/vimoutliner/vimoutliner.git" },

    -- LSP-related
    { src = "https://github.com/neovim/nvim-lspconfig.git" },
    { src = "https://github.com/mason-org/mason.nvim.git" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },

    -- AI assistant
    { src = "https://github.com/zbirenbaum/copilot.lua.git" },
    { src = "https://github.com/CopilotC-Nvim/CopilotChat.nvim" },
    { src = "https://github.com/ravitemer/mcphub.nvim.git" },

    -- Latex
    { src = "https://github.com/jbyuki/nabla.nvim.git" },
})

-- colorscheme
vim.cmd.colorscheme 'xoria256'
vim.g.lightline = {
    colorscheme = 'xoria256',
    active = {
        left = {
            { 'mode', 'paste' },
            { 'gitbranch', 'readonly', 'filename', 'modified' }
        }
    },
    component_function = {
        gitbranch = 'FugitiveStatusline'
    }
}

-- Enable cfilter plugin to filter the quickfix.
-- Cfilter! /{pat}/
-- :cdo s/search1/replace1/g
-- :wall
vim.cmd.packadd('cfilter')

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
    }
})

-- treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'c', 'cpp', 'python', 'lua', 'bash', 'make', 'cmake', 'devicetree',
        'bitbake', 'markdown', 'gitcommit', 'json'
    },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = false,
        additional_vim_regex_highlighting = false,
    }
}

-- LSP
require('mason').setup()
require('mason-lspconfig').setup {
    ensure_installed = { 'clangd', 'pyright', 'lua_ls', 'bashls', 'cmake' },
    automatic_enable = true
}

local cmp_lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('clangd', {
    -- nvim-cmp almost supports LSP's capabilities so advertise it to LSP servers.
    capabilities = cmp_lsp_capabilities
})

-- Completion
local cmp = require('cmp')
require('cmp').setup {
    sources = {
      { name = 'copilot' },
      { name = 'nvim_lsp', keyword_length = 1 },
      { name = 'path' },
      {
          name = 'buffer',
          keyword_length = 3,
          option = {
              -- Complete from all the buffers
              get_bufnrs = function()
                  return vim.api.nvim_list_bufs()
              end
          }
      }
    },
    completion = {
        -- Disable automatic autocomplete
        autocomplete = false
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
    })
}

-- Copilot completion
-- It is recommended to disable copilot.lua's suggestion and panel modules,
-- as they can interfere with completions properly appearing in copilot-cmp.
require('copilot_cmp').setup()
require('copilot').setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
    should_attach = function(bufnr)
        return true
    end,
})

-- Copilot chat
require('CopilotChat').setup({
    model = "claude-sonnet-4.5",
    window = {
        layout = 'float',
        height = 0.8,
        width = 0.8
    }
})

-- MCP Hub
-- mcp-hub can be  installed with:
--     npm install -g mcp-hub@latest
require('mcphub').setup({
    extensions = {
        copilotchat = {
            enabled = true,
            convert_tools_to_functions = true,     -- Convert MCP tools to CopilotChat functions
            convert_resources_to_functions = true, -- Convert MCP resources to CopilotChat functions
            add_mcp_prefix = false,                -- Add "mcp_" prefix to function names
        }
    }
})
