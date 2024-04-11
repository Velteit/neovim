local mappings = require("mappings");

return {
		"smoka7/hop.nvim",
		event = "BufEnter",
		init = function()
			local hop = require("hop")
			local hint = require("hop.hint")
			local directions = hint.HintDirection
			local position = require("hop.hint").HintPosition

			mappings:add_mapping("n", "<leader><leader>f", {
				function()
					hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
				end,
				"Hop to char",
			})
			mappings:add_mapping("v", "<leader><leader>f", {
				function()
					hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
				end,
				"Hop to char",
			})
			mappings:add_mapping("n", "<leader><leader>F", {
				function()
					hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
				end,
				"Hop to char backward",
			})
			mappings:add_mapping("v", "<leader><leader>F", {
				function()
					hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
				end,
				"Hop to char backward",
			})
			mappings:add_mapping("n", "<leader><leader>t", {
				function()
					hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
				end,
				"Hop before char",
			})
			mappings:add_mapping("v", "<leader><leader>t", {
				function()
					hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
				end,
				"Hop before char",
			})
			mappings:add_mapping("n", "<leader><leader>T", {
				function()
					hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = -1 })
				end,
				"Hop before char backward",
			})
			mappings:add_mapping("v", "<leader><leader>T", {
				function()
					hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = -1 })
				end,
				"Hop before char backward",
			})
			mappings:add_mapping("n", "<leader><leader>k", {
				function()
					hop.hint_lines({ direction = directions.BEFORE_CURSOR })
				end,
				"Hop to line up",
			})
			mappings:add_mapping("v", "<leader><leader>k", {
				function()
					hop.hint_lines({ direction = directions.BEFORE_CURSOR })
				end,
				"Hop to line up",
			})
			mappings:add_mapping("n", "<leader><leader>j", {
				function()
					hop.hint_lines({ direction = directions.ADTER_CURSOR })
				end,
				"Hop to line down",
			})
			mappings:add_mapping("v", "<leader><leader>j", {
				function()
					hop.hint_lines({ direction = directions.ADTER_CURSOR })
				end,
				"Hop to line down",
			})
			mappings:add_mapping("n", "<leader><leader>w", {
				function()
					hop.hint_words({ direction = directions.AFTER_CURSOR })
				end,
				"Hop to word start",
			})
			mappings:add_mapping("v", "<leader><leader>w", {
				function()
					hop.hint_words({ direction = directions.AFTER_CURSOR })
				end,
				"Hop to word start",
			})
			mappings:add_mapping("n", "<leader><leader>e", {
				function()
					hop.hint_words({ direction = directions.AFTER_CURSOR, hint_position = position.END })
				end,
				"Hop to word end",
			})
			mappings:add_mapping("v", "<leader><leader>e", {
				function()
					hop.hint_words({ direction = directions.AFTER_CURSOR, hint_position = position.END })
				end,
				"Hop to word end",
			})
		end,
		opts = function()
			return require("configs.hop")
		end,
		config = function(_, opt)
			require("hop").setup(opt)
		end,
	};
