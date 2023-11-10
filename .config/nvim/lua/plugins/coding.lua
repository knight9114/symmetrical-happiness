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
                add = "gsa",
                delete = "gsd",
                find = "gsf",
                find_left = "gsF",
                highlight = "gsh",
                replace = "gsr",
                update_n_lines = "gsn",
            },
        },
    },
    {
        "echasnovski/mini.comment",
        event = { "VeryLazy" },
        config = function()
            require("mini.comment").setup()
        end,
    },
}
