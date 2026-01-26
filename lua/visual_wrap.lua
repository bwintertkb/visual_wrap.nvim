local BRACKET_MATCH = {
	["{"] = "}",
	["["] = "]",
	["("] = ")",
	["<"] = ">",
	['"'] = '"',
	["'"] = "'",
	["`"] = "`",
}

local M = {}

local config = {
	silent = true,
	keymaps = {
		["["] = "<leader>[",
		["]"] = "<leader>]",
		["{"] = "<leader>{",
		["}"] = "<leader>}",
		["("] = "<leader>(",
		[")"] = "<leader>)",
		["<"] = "<leader><",
		[">"] = "<leader>>",
		['"'] = '<leader>"',
		["'"] = "<leader>'",
		["`"] = "<leader>`",
	},
}

local function get_opening_bracket_row_shift(str)
	if string.match(str, "%a") == str:sub(1, 1) then
		return 0
	end
	local tabs = string.match(str, "^[\t ]+")
	local num_tabs = tabs and #tabs or 0
	return num_tabs
end

local function get_visual_range()
	local start_ = vim.api.nvim_buf_get_mark(0, "<")
	local end_ = vim.api.nvim_buf_get_mark(0, ">")
	local lines = vim.api.nvim_buf_get_lines(0, end_[1] - 1, end_[1], false)
	if end_[2] >= 2147483647 then
		end_[2] = #lines[1]
	elseif end_[2] < #lines[1] then
		end_[2] = end_[2] + 1
	end
	local text = vim.api.nvim_buf_get_text(0, start_[1] - 1, start_[2], end_[1] - 1, end_[2], {})
	local row_shift = get_opening_bracket_row_shift(text[1])
	start_[2] = start_[2] + row_shift
	return start_[1], start_[2], end_[1], end_[2]
end

function M.wrap(bracket)
	local start_row, start_col, end_row, end_col = get_visual_range()
	start_row = start_row - 1
	end_row = end_row - 1
	local text = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
	text[1] = bracket .. text[1]
	text[#text] = text[#text] .. BRACKET_MATCH[bracket]
	vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, text)
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_cursor(win, { start_row + 1, start_col })
end

-- Map a bracket key to its opening bracket for wrapping
local BRACKET_TO_OPENER = {
	["}"] = "{",
	["]"] = "[",
	[")"] = "(",
	[">"] = "<",
}

M.setup = function(opts)
	opts = opts or {}
	config.silent = opts.silent or false
	if opts.keymaps then
		config.keymaps = vim.tbl_deep_extend("force", config.keymaps, opts.keymaps)
	end

	local keymap_opts = { noremap = true, silent = config.silent }

	for bracket, lhs in pairs(config.keymaps) do
		if lhs then
			local opener = BRACKET_TO_OPENER[bracket] or bracket
			local escaped = opener:gsub("'", "\\'")
			vim.api.nvim_set_keymap("v", lhs, ":lua require('visual_wrap').wrap('" .. escaped .. "')<CR>", keymap_opts)
		end
	end
end

return M
