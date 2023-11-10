-- [[
--  Coding Configurations
--
--  This file contains the plugins that add functionality to coding. These
--  plugins cover things such as auto-pairs, surrounding, and comments.
-- ]]
return {
    { "tpope/vim-sleuth" },
    {
        "echasnovski/mini.pairs",
        event = { "VeryLazy" },
        version = false,
        config = function()
            require("mini.pairs").setup()
        end,
    },
    {
        "echasnovski/mini.surround",
        event = { "VeryLazy" },
        version = false,
        opts = {
            mappings = {
                add = "<leader>sa",
                delete = "<leader>sd",
                find = "<leader>sf",
                find_left = "<leader>sF",
                highlight = "<leader>sh",
                replace = "<leader>sr",
                update_n_lines = "<leader>sn",
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.register({
                ["<leader>s"] = {
                    name = "+mini.surround",
                }
            })
        end,
    },
    {
        "echasnovski/mini.comment",
        event = { "VeryLazy" },
        config = function()
            require("mini.comment").setup()
        end,
    },
}
