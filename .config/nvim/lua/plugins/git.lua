-- [[
--  Git Configurations
--
--  This file contains the plugin for using Git within Neovim.
-- ]]
return {
    {
        "tpope/vim-fugitive",
        cmd = { "Git" },
        event = { "VeryLazy" },
        keys = {
            { "<leader>Gs", "<cmd>Git status -uall<cr>", desc = "Git status" },
            { "<leader>Ga", "<cmd>Git add ", desc = "Git add" },
            { "<leader>GA", "<cmd>Git add --all<cr>", desc = "Git add all" },
            { "<leader>Gc", "<cmd>Git commit", desc = "Git commit" },
            { "<leader>Gp", "<cmd>Git pull<cr>", desc = "Git pull" },
            { "<leader>GP", "<cmd>Git push<cr>", desc = "Git push" },
        },
    },
}
