-- Colorscheme
vim.cmd.colorscheme("catppuccin")

-- Mini
require("mini.ai").setup()
require("mini.basics").setup({
    options = {
        basic = true,
    },
    mappings = {
        basic = true,
    }
})
require("mini.bracketed").setup({
    undo = nil,
})
require("mini.comment").setup()
require("mini.completion").setup()
require("mini.indentscope").setup()
require("mini.move").setup()
require("mini.pairs").setup()
require("mini.sessions").setup({
    file = ".session.vim",
})
require("mini.starter").setup()
require("mini.surround").setup()
require("mini.tabline").setup()

-- LSP
local lspconfig = require("lspconfig")
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(event)
        vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>lf", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})
lspconfig.pylsp.setup({
})
