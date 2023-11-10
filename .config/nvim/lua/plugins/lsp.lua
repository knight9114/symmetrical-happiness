-- [[
--  Language Server and Treesitter Configurations
--
--  This file contains the plugins related to treesitter, LSP functionality,
--  and diagnostics. Such functions are completion, syntax highlighting, and
--  formatting.
-- ]]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "c",
                    "cpp",
                    "lua",
                    "python",
                    "rust",
                    "go",
                    "ocaml",
                    "zig",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "echasnovski/mini.ai",
        version = false,
        event = { "VeryLazy" },
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({
                        a = { "@funtion.outer" },
                        i = { "@funtion.inner" },
                    }, {}),
                    c = ai.gen_spec.treesitter({
                        a = { "@class.outer" },
                        i = { "@class.inner" },
                    }, {}),
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                },
            }
        end,
        config = function(_, opts)
            require("mini.ai").setup(opts)
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document diagnostics" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace diagnostics" },
            { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble location list" },
            { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble quickfix" },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").previous({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Previous quickfix item",
            },
            {
                "]q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cnext)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Next quickfix item",
            }
        },
        init = function()
            local wk = require("which-key")
            wk.register({
                ["<leader>x"] = {
                    name = "+trouble"
                }
            })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            { 
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
        opts = { history = true, delete_check_events = "TextChanged" },
    },
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = { "InsertEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()
            return {
                completion = { completeopt = "menu,menuone,noinsert" },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                }),
                experimental = { ghost_text = { hl_group = "CmpGhostText" } },
                sorting = defaults.sorting,
            }
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
            { "folke/neodev.nvim", opts = {} },
        },
        init = function()
            local wk = require("which-key")
            wk.register({
                ["<leader>l"] = {
                    name = "+lsp",
                    D = "LSP Declaration",
                    d = "LSP Definition",
                    K = "LSP Hover",
                    i = "LSP Implementation",
                    k = "LSP Signature",
                    t = "LSP Type definition",
                    r = "LSP Rename symbol",
                    c = "LSP Code action",
                    R = "LSP References",
                },
                ["<leader>lw"] = {
                    name = "+workspace",
                    a = "LSP Add workspace",
                    r = "LSP Remove workspace",
                    l = "LSP List workspaces",
                },
            })
        end,
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.pylsp.setup({
                settings = {
                    pylsp = {
                        plugins = {
                            black = { enabled = true },
                            ruff = { enabled = true },
                        }
                    }
                }
            })
            lspconfig.gopls.setup({})
            lspconfig.rust_analyzer.setup({})
            lspconfig.clangd.setup({})
            lspconfig.lua_ls.setup({})
            lspconfig.ocamllsp.setup({})
            lspconfig.zls.setup({})

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "LSP Declaration" })
                    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { buffer = ev.buf, desc = "LSP Definition" })
                    vim.keymap.set("n", "<leader>lK", vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP Hover" })
                    vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "LSP Implementation" })
                    vim.keymap.set("n", "<leader>lk", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "LSP Signature" })
                    vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = "LSP Add workspace" })
                    vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = "LSP Remove workspace" })
                    vim.keymap.set("n", "<leader>lwl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, { buffer = ev.buf, desc = "LSP List workspaces" })
                    vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "LSP Type definition" })
                    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP Rename" })
                    vim.keymap.set({ "n", "v" }, "<leader>lc", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "LSP Code action" })
                    vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references, { buffer = ev.buf, desc = "LSP References" })
                end,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>lf",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = { "n", "v" },
                desc = "LSP Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                golang = { "gofmt" },
                rust = { "rustfmt" },
            },
        },
    }
}
