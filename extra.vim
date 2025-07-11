" VIMSCRIPTS

" " Default overwirte 
" -- <Tab> key settings
" set tabstop=2       " Number of spaces that a <Tab> in the file counts for.
" set shiftwidth=2    " Number of spaces to use for each step of (auto)indent.
" set expandtab       " Use spaces instead of tabs.
" set softtabstop=2   " Number of spaces <Tab> counts for while editing.

" " Theme
" colorscheme retrobox

" " Utilities
" -- // : search current selected (visual mode)
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
" -- Explore more at
" -- https://vim.fandom.com/wiki/Search_for_visually_selected_text

" -- \C : open current file at current position in VScode (mormal mode)
"nnoremap \C :execute '!code -g ' . expand('%') . ':' . line('.') . ':' . col('.')<CR>
command! LaunchVSCode execute '!code -g ' . expand('%') . ':' . line('.') . ':' . col('.')
nnoremap \C :LaunchVSCode<CR>

" " Plugins config - for `lazy.nvim`
" -- Gitsigns
" highlight GitSignsAdd guifg=Lime guibg=Green


" -- This is how to make vim-plug works alongside with lazy.nvim
" -- - Install  vim-plug
" -- - https://github.com/junegunn/vim-plug?tab=readme-ov-file#neovim
"
" -- ```sh
" --  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" --      
" -- ```
"
" -- Add plugins
" -- Open new process and run :PlugInstall
" -- NOTE:
" --   Eventually, vim-plug and lazy.nvim have different file tree 
" --   location so we don't have to worry about files conflict.
" --   But still have to be cautious about plugins' functions conflict.

call plug#begin()

Plug 'preservim/nerdtree'

Plug 'sindrets/diffview.nvim' " Will move to lazy.nvim later

call plug#end()

" -- NOTE:
" --   Plugins from vim-plug not loaded at the first run.
" --   Need to run `:PlugInstall` manually or `:source extra.vim` again to take effect.
" --   This is a workaround for the issue
autocmd VimEnter * if !exists(':NERDTree')
  \| PlugInstall --sync | q | wincmd p
\| endif

" " Plugins config - for `vim-plug`
" -- Nerdtree
nnoremap <F2> :NERDTreeToggle<CR>

" -- Diffview
nnoremap <silent> \do :DiffviewOpen<CR>
nnoremap <silent> \dc :DiffviewClose<CR>
nnoremap <silent> \dh :DiffviewFileHistory<CR>
nnoremap <silent> \df :execute 'DiffviewFileHistory ' . expand('%')<CR>

"highlight DiffAdd guibg=green
"highlight DiffDelete guibg=red
"highlight DiffChange guibg=orange
"highlight DiffText guibg=yellow
