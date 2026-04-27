vim.cmd('highlight StatusLineBold gui=bold cterm=bold')

function FilepathStatus()
	local winwidth = vim.api.nvim_win_get_width(0)
	local parentSegment = vim.fn.expand('%:p:h:h')
	local cwdSegment = vim.fn.fnamemodify(vim.fn.expand('%:h'), ':~:.')
	local fileSegment = vim.fn.expand('%:t')

	if winwidth > 60 then
		-- print full path, and truncate file path from left, so parent directories are cut off
		return "%<"
			.. "%#StatusLineNC#" .. parentSegment .. "/%*"
			.. cwdSegment .. "/"
			.. "%#StatusLineBold#" .. fileSegment .. "%*"
			.. "  "
	else
		-- very narrow window
		-- print only filename, and truncate from right, so filename is always visible
		return ""
			.. "%#StatusLineBold#" .. fileSegment .. "%*"
			.. "  %<"
	end
end

vim.opt.statusline = ""
.. "[%n]" -- buffernr
.. "%#Todo#%m%r%w%* " -- modified/readonly
-- .. "%<%f" -- file
.. "%{% luaeval('FilepathStatus()') %}" -- file
.. "%{% v:lua.require('vim._core.util').term_exitcode() %}" -- terminal exitcode
.. "%=" -- divider
.. "%{% luaeval('(package.loaded[''vim.ui''] and vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin or -1) and vim.ui.progress_status()) or '''' ')%}" -- progress messages 
.. "%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}" -- command text, not used
.. "%=" -- divider
.. "%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}"
.. "%{% &busy > 0 ? '◐ ' : '' %}" -- busy
.. "%#Todo#%{ luaeval('vim.lsp.status()') }%* " -- lsp
.. "%{% luaeval('(package.loaded[''vim.diagnostic''] and next(vim.diagnostic.count()) and vim.diagnostic.status() .. '' '') or '''' ') %}" -- diagnostics
.. "%{''.(&fenc!=''?&fenc:&enc).''}" -- Encoding
.. "%{(&bomb?\",BOM\":\"\")}" -- Encoding2
.. "[%{&ff}] " -- FileFormat (dos/unix..)
.. "%y " -- FileType
-- .. "0x%04B " -- character under cursor
.. "%{% &ruler ? ( &rulerformat == '' ? '%l:%v %p%%' : &rulerformat ) : '' %} "

local augroupStatusline = vim.api.nvim_create_augroup('config.Statusline', {})
vim.api.nvim_create_autocmd('LspProgress', {
	pattern = '*',
	callback = function()
		vim.cmd('redrawstatus')
	end,
	group = augroupStatusline,
})
