-- [[
--  Refactoring Configurations
--
--  This file contains the plugins for refactoring code.
-- ]]
return {
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            {
                "<leader>rr",
                function()
                    require("refactoring").select_refactor()
                end,
                mode = { "n", "x" },
                desc = "Select refactoring",
            },
        },
        config = function()
            require("refactoring").setup({
                prompt_func_return_type = {
                    go = true,
                    cpp = true,
                    c = true,
                    python = true,
                },
                prompt_func_param_type = {
                    go = true,
                    cpp = true,
                    c = true,
                    python = true,
                }
            })
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        keys = {
            {
                "<leader>rn",
                function()
                    return ":IncRename " .. vim.fn.expand("<cword>")
                end,
                expr = true,
                desc = "LSP Rename symbol under cursor",
            },
        },
        opts = {
            input_buffer_type = "dressing",
        },
    }
}
