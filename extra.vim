" VIMSCRIPTS

" " Configure tab settings
"set tabstop=2       " Number of spaces that a <Tab> in the file counts for.
"set shiftwidth=2    " Number of spaces to use for each step of (auto)indent.
"set expandtab       " Use spaces instead of tabs.
"set softtabstop=2   " Number of spaces <Tab> counts for while editing.

" " Theme
" colorscheme retrobox

" " Utilities
" -- // : search current selected (visual mode)
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
" Explore more at
" https://vim.fandom.com/wiki/Search_for_visually_selected_text

" -- \C : open current file at current position in VScode (mormal mode)
"nnoremap \C :execute '!code -g ' . expand('%') . ':' . line('.') . ':' . col('.')<CR>
command! LaunchVSCode execute '!code -g ' . expand('%') . ':' . line('.') . ':' . col('.')
nnoremap \C :LaunchVSCode<CR>

" " Plugins
" Gitsigns
" highlight GitSignsAdd guifg=Lime guibg=Green
