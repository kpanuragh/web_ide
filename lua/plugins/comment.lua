return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- Required for commenting embedded languages like JSX, TSX, Blade, etc.
		require("ts_context_commentstring").setup({})
		vim.g.skip_ts_context_commentstring_module = true

		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

			--- Add space between comment and code
			padding = true,

			--- Whether the cursor should stay in place
			sticky = true,

			--- Lines to ignore while (un)commenting
			ignore = nil,

			--- Mappings
			mappings = {
				basic = true, -- normal mode: gcc, gc
				extra = true, -- gco, gcO, gcA
				extended = false, -- block (Visual mode): gb
			},

			--- LHS of toggle mappings
			toggler = {
				line = "gcc",
				block = "gbc",
			},

			--- LHS of operator-pending mappings
			opleader = {
				line = "gc",
				block = "gb",
			},

			--- LHS of extra mappings
			extra = {
				above = "gcO", -- comment line above
				below = "gco", -- comment line below
				eol = "gcA", -- comment at end of line
			},
		})
	end,
}
