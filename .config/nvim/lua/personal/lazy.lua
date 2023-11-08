require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = { lazy = true, version = false },
    install = { colorscheme = { "catppuccin" } },
    checker = { enabled = true, notify = false },
    change_detection = { notify = false },
    performance = {
        cache = { enabled = true },
        rtp = {
            reset = true,
            disabled_plugins = {
                "man",
                "gzip",
                "tarPlugin",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
