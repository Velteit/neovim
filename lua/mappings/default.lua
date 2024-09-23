return {
	n = {
		["<Esc>"] = { ":noh <CR>", "Clear highlights" },

		["<leader>sv"] = { ":Vexplore<CR>", "Split verticaly" },
		["<leader>sh"] = { ":Hexplore<CR>", "Split horizontaly" },

		["<leader>bl"] = { "<C-w>l", "Switch right" },
		["<leader>bh"] = { "<C-w>h", "Switch left" },
		["<leader>bk"] = { "<C-w>k", "Switch up" },
		["<leader>bj"] = { "<C-w>j", "Switch down" },

		["<leader>ml"] = { "<C-w>L", "Move right" },
		["<leader>mh"] = { "<C-w>H", "Move left" },
		["<leader>mk"] = { "<C-w>K", "Move up" },
		["<leader>mj"] = { "<C-w>J", "Move down" },
		["<leader>bn"] = { "<cmd>bnext<CR>", "Next buffer" },
		["<leader>bp"] = { "<cmd>bprevious<CR>", "Previous buffer" },
	},
	v = {},
	i = {},
}
