require("options")
require("plugins")
require("keymaps")

if vim.loop.fs_stat(vim.fn.stdpath("config") .. "/lua/corp.lua") then
    require("corp")
end
