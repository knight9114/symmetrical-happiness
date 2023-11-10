-- [[
--  Editor Configurations
--
--  This file contains the plugins for managing the editor. These plugins cover
--  actions such as manipulating the file system, visual cues in the editor,
--  and whatnot.
-- ]]
return {
    {
        "echasnovski/mini.files",
        version = false,
        event = { "VeryLazy" },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader>m", function() require("mini.files").open() end, desc = "Open file explorer" },
        },
        init = function()
            local wk = require("which-key")
            wk.register({
                ["<leader>"] = {
                    m = "+mini.files",
                }
            })
        end,
        config = function()
            require("mini.files").setup({
                options = {
                    permanent_delete = true,
                },
            })
        end,
    },
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = { "VeryLazy" },
        config = function()
            require("mini.indentscope").setup()
        end,
    },
    {
        "echasnovski/mini.starter",
        version = false,
        event = { "VimEnter" },
        config = function()
            require("mini.starter").setup()
        end,
    },
    {
        "ThePrimeagen/harpoon",
        event = { "VeryLazy" },
        keys = {
            { "<leader>h1", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon file 1" },
            { "<leader>h2", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon file 2" },
            { "<leader>h3", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon file 3" },
            { "<leader>h4", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon file 4" },
            { "<leader>h5", function() require("harpoon.ui").nav_file(5) end, desc = "Harpoon file 5" },
            { "<leader>h6", function() require("harpoon.ui").nav_file(6) end, desc = "Harpoon file 6" },
            { "<leader>h7", function() require("harpoon.ui").nav_file(7) end, desc = "Harpoon file 7" },
            { "<leader>h8", function() require("harpoon.ui").nav_file(8) end, desc = "Harpoon file 8" },
            { "<leader>h9", function() require("harpoon.ui").nav_file(9) end, desc = "Harpoon file 9" },
            { "<leader>h0", function() require("harpoon.ui").nav_file(10) end, desc = "Harpoon file 10" },
            { "<leader>ha", function() require("harpoon.mark").add_file() end, desc = "Harpoon add file" },
            { "<leader>hm", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon menu" },
            { "<leader>hp", function() require("harpoon.ui").nav_prev() end, desc = "Harpoon previous mark" },
            { "<leader>hn", function() require("harpoon.ui").nav_next() end, desc = "Harpoon next mark" },
            { "<leader>ht1", function() require("harpoon.term").gotoTerminal(1) end, desc = "Harpoon terminal 1" },
            { "<leader>ht2", function() require("harpoon.term").gotoTerminal(2) end, desc = "Harpoon terminal 2" },
            { "<leader>ht3", function() require("harpoon.term").gotoTerminal(3) end, desc = "Harpoon terminal 3" },
            { "<leader>ht4", function() require("harpoon.term").gotoTerminal(4) end, desc = "Harpoon terminal 4" },
        },
        init = function()
            local wk = require("which-key")
            wk.register({
                ["<leader>h"] = {
                    name = "+harpoon",
                },
            })
        end,
        config = function()
            require("harpoon").setup({
                global_settings = {
                    save_on_toggle = true,
                    save_on_change = true,
                    mark_branch = false,
                },
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = { "Telescope" },
        event = { "VeryLazy" },
        version = false,
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope grep_string<cr>", desc = "Grep for string" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
            { "<leader>fli", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "LSP incoming calls" },
            { "<leader>flo", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "LSP outgoing calls" },
        },
        init = function()
            local wk = require("which-key")
            wk.register({
                ["<leader>f"] = {
                    name = "+telescope",
                    l = "+lsp",
                }
            })
        end,
        config = function()
            require("telescope").setup()
        end,
    },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "VeryLazy" },
        config = true,
        keys = {
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        }
    },
    {
        "folke/noice.nvim",
        event = { "VeryLazy" },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        keys = {
            { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice last message" },
            { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice history" },
            { "<leader>na", function() require("noice").cmd("all") end, desc = "All noice messages" },
            { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss noice messages" },
        },
        opts = {
            lsp = {
                progress = {
                    enabled = true,
                    view = "mini",
                    throttle = 1000 / 60,
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                }
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
        },
        init = function()
            local wk = require("which-key")
            wk.register({
                ["<leader>n"] = {
                    name = "+noice",
                }
            })
        end,
    },
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = { "VeryLazy" },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = false,
                    section_separators = "",
                    component_separators = "",
                }
            })
        end,
    }
}
