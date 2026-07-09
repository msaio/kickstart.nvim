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
" -- NOTE:
" -- Explore more at:
" -- https://vim.fandom.com/wiki/Search_for_visually_selected_text

" -- \C : open current file at current position in VScode (mormal mode)
"nnoremap \C :execute '!code -g ' . expand('%') . ':' . line('.') . ':' . col('.')<CR>
command! LaunchVSCode execute '!code . && code -g ' . expand('%') . ':' . line('.') . ':' . col('.')
nnoremap \c :LaunchVSCode<CR>

" -- Tabs
" -- \tc : Close current tab
nnoremap \tc :tabc<CR>

" -- \tl : Create new tab on the left
nnoremap \tl :-1tabnew<CR>

" -- \tr : Create new tab on the right (Default)
nnoremap \tr :tabnew<CR>
" -- \tn : Create new tab at specified index
function! CreateNewTabAtIndex()
  let index = input('Enter tab index (0-based): ')
  if index != ''
    let index_num = str2nr(index)
    execute 'tabnew'
    execute 'tabmove ' . index_num
  endif
endfunction
" -- NOTE: 
" -- To manual create new tab at specific index 
" -- Hit :tabnew | tabmove <index>
" -- Ex: :tabnew | tabmove -1
nnoremap \tn :call CreateNewTabAtIndex()<CR>

" -- Folds
function! FoldManual()
  execute 'set foldmethod=manual'
endfunction
"
function! FoldIndent()
  execute 'set foldmethod=indent'
endfunction
"
" -- \fi : Set Fold indent
nnoremap \fi :call FoldIndent()<CR>
" -- \fm : Set Fold manual
nnoremap \fm :call FoldManual()<CR>


" -- This is how to make vim-plug works alongside with lazy.nvim
" -- - Install  vim-plug
" -- - https://github.com/junegunn/vim-plug?tab=readme-ov-file#neovim
"
" -- ```sh
" --  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" --      
" -- ```
"
" -- Plugins
" -- Open new process and run :PlugInstall
" -- NOTE:
" --   Eventually, vim-plug and lazy.nvim have different file tree 
" --   location so we don't have to worry about files conflict.
" --   But still have to be cautious about plugins' functions conflict.

call plug#begin()

Plug 'preservim/nerdtree'


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


"highlight DiffAdd guibg=green
"highlight DiffDelete guibg=red
"highlight DiffChange guibg=orange
"highlight DiffText guibg=yellow
