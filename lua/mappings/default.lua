return {
	n = {
		["<Esc>"] = { ":noh <CR>", "Clear highlights" },

		["<leader>sv"] = { ":vsplit<CR>", "Split verticaly" },
		["<leader>sh"] = { ":split<CR>", "Split horizontaly" },

		["<leader>bl"] = { "<C-w>l", "Swith right" },
		["<leader>bh"] = { "<C-w>h", "Swith left" },
		["<leader>bk"] = { "<C-w>k", "Swith up" },
		["<leader>bj"] = { "<C-w>j", "Swith down" },

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
