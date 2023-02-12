local BRACKET_MATCH = { ["{"] = "}", ["["] = "]", ["("] = ")", ["<"] = ">", ['"'] = '"', ["\'"] = "\'" }

local function get_opening_bracket_row_shift(str)
	-- this is to account for any tabs or whitespace before the character
	-- check if the first character is alphanumeric
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
	-- Setting the first column number to match that of a character
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

function visual_wrap(bracket)
	if bracket == 'single_quote' then
		bracket = '\''
	end
	local start_row, start_col, end_row, end_col = get_visual_range()
	start_row = start_row - 1
	end_row = end_row - 1
	local text = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
	text[1] = bracket .. text[1]
	text[#text] = text[#text] .. BRACKET_MATCH[bracket]
	vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, text)
end

M = {}

M.setup = function ()
	-- Set the keybindings for the visual_wrap
	vim.api.nvim_set_keymap("v", "<leader>[", ":lua visual_wrap('[')<CR>", { noremap = true })
	vim.api.nvim_set_keymap("v", "<leader>]", ":lua visual_wrap('[')<CR>", { noremap = true })
	vim.api.nvim_set_keymap("v", "<leader>{", ":lua visual_wrap('{')<CR>", { noremap = true })
	vim.api.nvim_set_keymap("v", "<leader>{", ":lua visual_wrap('{')<CR>", { noremap = true })
	vim.api.nvim_set_keymap("v", "<leader>(", ":lua visual_wrap('(')<CR>", { noremap = true })
	vim.api.nvim_set_keymap("v", "<leader>)", ":lua visual_wrap('(')<CR>", { noremap = true })
	vim.api.nvim_set_keymap("v", "<leader><", ":lua visual_wrap('<')<CR>", { noremap = true })
	vim.api.nvim_set_keymap("v", "<leader>>", ":lua visual_wrap('<')<CR>", { noremap = true })
	vim.api.nvim_set_keymap("v", "<leader>\"", ":lua visual_wrap('\"')<CR>", { noremap = true })
	vim.api.nvim_set_keymap("v", "<leader>\'", ":lua visual_wrap('single_quote')<CR>", { noremap = true })
end

return M



