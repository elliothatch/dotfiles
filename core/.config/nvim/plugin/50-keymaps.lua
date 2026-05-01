vim.keymap.set('n', '<space>', '<leader>', {remap = true})

-- buffer management 
vim.keymap.set('n', '<leader>w', function() vim.cmd('write') end)
vim.keymap.set('n', '<leader>l', function() vim.cmd('bnext') end)
vim.keymap.set('n', '<leader>h', function() vim.cmd('bprevious') end)
vim.keymap.set('n', '<leader>n', function() vim.cmd('enew') end)

-- close buffer without closing the window
-- switch to alternate buffer and close the buffer we were just on
-- if the alternate buffer is unlisted, go to the previous buffer instead
-- if we are closing the last listed buffer, create a new blank buffer to switch to
-- TODO: rewrite in lua
vim.cmd([[
nnoremap <expr> <leader>q len(getbufinfo({'buflisted':1})) == 1 ? ':enew<cr>:bd#<cr>' : (buflisted(bufnr('#')) ? ':b #<cr>:bd #<cr>' : ':bp<cr>:bd #<cr>')
]])

-- visual cursor movement
vim.keymap.set('n', 'j', 'gj', {silent = true})
vim.keymap.set('n', 'k', 'gk', {silent = true})
vim.keymap.set('n', 'gj', 'j', {silent = true})
vim.keymap.set('n', 'gk', 'k', {silent = true})

-- line navigation
vim.keymap.set('n', 'H', '^', {silent = true})
vim.keymap.set('n', 'L', '$', {silent = true})
vim.keymap.set('v', 'L', 'g_', {silent = true})
vim.keymap.set('c', '<C-A>', '<HOME>', {silent = true})
vim.keymap.set('c', '<C-E>', '<END>', {silent = true})

-- go to last change, similar to 'gi' (go to last insert mode location)
vim.keymap.set('n', 'gI', '`', {silent = true})

-- windows
vim.keymap.set('n', '<leader>Q', function() vim.cmd('close') end)
vim.keymap.set('n', '<leader>v', function() vim.cmd('vsplit') end)
vim.keymap.set('n', '<leader>V', function() vim.cmd('split') end)

-- window navigation
vim.keymap.set('n', '<C-K>', function() vim.cmd('wincmd k') end, {silent = true})
vim.keymap.set('n', '<C-J>', function() vim.cmd('wincmd j') end, {silent = true})
vim.keymap.set('n', '<C-L>', function() vim.cmd('wincmd l') end, {silent = true})
vim.keymap.set('n', '<C-H>', function() vim.cmd('wincmd h') end, {silent = true})

-- clear search highlight
vim.keymap.set('n', '<leader>,', function() vim.cmd('nohlsearch') end, {silent = true})


-- shift in visual mode
vim.keymap.set('v', '>', '>gv', {silent = true})
vim.keymap.set('v', '<', '<gv', {silent = true})

-- sort visual lines
vim.keymap.set('v', 's', function() vim.cmd('sort') end)

-- select contents of current line, excluding indentation
vim.keymap.set('n', 'vv', '^vg_', {silent = true})

-- focus the current line (close all folds except this one, then center the screen)
vim.keymap.set('n', '<leader>z', 'zMzvzz', {silent = true})

-- Quickfix list
vim.keymap.set('n', '<leader>co', function() vim.cmd('botright copen') end)
vim.keymap.set('n', '<leader>cc', function() vim.cmd('cclose') end)

vim.keymap.set('n', '<leader>Co', function() vim.cmd('botright lopen') end)
vim.keymap.set('n', '<leader>Cc', function() vim.cmd('lclose') end)

-- preview window
-- nnoremap <leader>m <C-w>}
-- nnoremap <leader>pc :pclose!<cr>

-- auto-formatting
-- TODO: replace with treesitter/lsp formatter
vim.keymap.set('n', '<leader>fj', function() vim.cmd('%! python -m json.tool') end)
vim.keymap.set('v', '<leader>fj', function() vim.cmd("'<,'>! python -m json.tool") end)
 -- format as hex
vim.keymap.set('n', '<leader>fh', function() vim.cmd('%!od -A x -t x1z -v') end, {expr=true})

-- terminal mode
vim.keymap.set('t', '<C-K>', '<C-\\><C-N><C-W>K', {silent = true})
vim.keymap.set('t', '<C-J>', '<C-\\><C-N><C-W>J', {silent = true})
vim.keymap.set('t', '<C-L>', '<C-\\><C-N><C-W>L', {silent = true})
vim.keymap.set('t', '<C-H>', '<C-\\><C-N><C-W>H', {silent = true})

-- LSP
vim.keymap.set('n', 'grd', function() vim.lsp.buf.definition() end, {silent=true})
vim.keymap.set('n', 'gre', function() vim.diagnostic.open_float() end, {silent=true})
vim.keymap.set('n', 'grE', function() vim.diagnostic.setloclist() end, {silent=true})

vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR}) end, {silent=true})
vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR}) end, {silent=true})

-- Plugins
-- nvim.undotree
-- vim.keymap.set('n', '<leader>u', function() vim.cmd('Undotree') end)

-- bbill/undotree
vim.keymap.set('n', '<leader>u', function() vim.cmd('UndotreeToggle') end)

-- ibhagwan/fzf-lua
vim.keymap.set('n', '<C-P>', function() require('fzf-lua').files() end)
vim.keymap.set('n', '<C-Space>', function() require('fzf-lua').buffers() end)

-- hrsh7th/nvim-cmp (auto completion)
-- replace omnifunc with cmp completion (better LSP capabilities)
vim.keymap.set('i', '<C-X><C-O>', function() require('cmp').complete() end)

-- mhinz/vim-grepper
vim.keymap.set('n', 'gs', '<Plug>(GrepperOperator)', {remap = true})
vim.keymap.set('x', 'gs', '<Plug>(GrepperOperator)', {remap = true})

vim.keymap.set('n', '<leader>ss', function() vim.cmd('Grepper') end)

-- andyg/leap.nvim
vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

-- enahnced f/t motions
-- leap "add_repeat_mappings" starts the search group from the cursor forward, meaning if you f in the middle of a line, you can't go backward with , (instead, it jumps to the _last_ occurance of the match on the window
-- not usable with the current configuration
-- do
-- 	local function ft(key_specific_args)
-- 		require('leap').leap(
-- 			vim.tbl_deep_extend('keep', key_specific_args, {
-- 				inputlen = 1,
-- 				inclusive = true,
-- 				opts = {
-- 					-- Force autojump.
-- 					labels = '',
-- 					-- Match the modes where you don't need labels (`:h mode()`).
-- 					safe_labels = vim.fn.mode(1):match('o') and '' or nil,
-- 					keys = {
-- 						next_target = ';',
-- 						prev_target = ',',
-- 					}
-- 				},
-- 			})
-- 		)
-- 	end
--
-- 	vim.keymap.set({'n', 'x', 'o'}, 'f', function() ft {} end)
-- 	vim.keymap.set({'n', 'x', 'o'}, 'F', function() ft {backward = true} end)
-- 	vim.keymap.set({'n', 'x', 'o'}, 't', function() ft {offset = -1} end)
-- 	vim.keymap.set({'n', 'x', 'o'}, 'T', function() ft {backward = true, offset = 1} end)
--
-- 	require('leap.user').add_repeat_mappings(';', ',', {
-- 		relative_directions = true,
-- 		modes = {'n', 'x', 'o'},
-- 	})
-- end
