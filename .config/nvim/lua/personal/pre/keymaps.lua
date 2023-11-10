-- Leaders
vim.g.mapleader = " "

-- Misc
vim.keymap.set("i", "jk", "<ESC>", {})

-- Telescope
vim.keymap.set(
	"n", "<leader>fd",
	function()
		require("telescope.builtin").live_grep({ search_dirs = { vim.api.nvim_buf_get_name(0) } })
	end,
	{ desc = "Search current directory" }
)

-- Substitution
vim.keymap.set("n", "<C-s>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])
