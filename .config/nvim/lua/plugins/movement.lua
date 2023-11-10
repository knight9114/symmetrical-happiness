-- [[
--  Movement Configurations
--
--  This file contains the plugins that add movement functionality. The
--  majority of these plugins focus on in-buffer jumping.
-- ]]
return {
    {
        "ggandor/leap.nvim",
        event = { "VeryLazy" },
        config = function()
            require("leap").add_default_mappings()
            require("leap").setup({
                highlight_unlabeled_phase_one_targets = false,
            })
        end,
    }
}
