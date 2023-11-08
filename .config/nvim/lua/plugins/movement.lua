return {
    {
        "ggandor/leap.nvim",
        enabled = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("leap").add_default_mappings()
        end,
    }
}
