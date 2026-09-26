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

Plug 'kdheepak/lazygit.nvim'

" -- TODO: This plugin is no longer in maintain, find alternatives
" --       Recommended: https://github.com/kazhala/close-buffers.nvim
Plug 'kazhala/close-buffers.nvim'

Plug 'unkiwii/vim-nerdtree-sync'

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

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

" -- Lazygit
" -- \ll: Open lazygit
nnoremap <silent> \ll :LazyGit<CR>
nnoremap <silent> \lh :LazyGitFilter<CR>
nnoremap <silent> \lf :LazyGitFilterCurrentFile<CR>

" -- [kazhala/close-buffers]
command! CloseUnusedBuffers execute 'BDelete! nameless hidden'
" -- \bd: Close all unused buffers (include hidden and nameless buffers)
nnoremap \bd :CloseUnusedBuffers<CR>


" -- [unkiwii/vim-nerdtree-sync]
let g:nerdtree_sync_cursorline = 1

" -- [Xuyuanp/nerdtree-git-plugin]
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
let g:NERDTreeGitStatusConcealBrackets = 1 " default: 0


" -- [junegunn/fzf.vim]
"
nnoremap \sg :RG <Enter>
nnoremap \sf :Files <enter>
" -- Using Ctrl-P/Ctrl-N for navigating last search keywords while fzf window opens
"
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Search history (enables ctrl-p / ctrl-n inside fzf to navigate history)
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Preview window
" Toggle with ctrl-L while opening
" Default: OFF
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.5, 'yoffset': 1.0 } }
let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-L']

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  tab copen
  cfirst
endfunction
" This is the default extra key bindings
let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }



" ====================================================
" Auto-highlight trailing spaces
"augroup TrailingSpaces
"  autocmd!
"  autocmd BufEnter,TextChanged,TextChangedI * call matchadd('ErrorMsg', '\s\+$')
"augroup END

" Toggle trailing spaces highlighting
let g:trailing_spaces_enabled = 0
let g:trailing_spaces_match_id = 0

function! ToggleTrailingSpaces()
  if g:trailing_spaces_enabled
    " Disable trailing spaces highlighting
    if g:trailing_spaces_match_id != 0
      call matchdelete(g:trailing_spaces_match_id)
      let g:trailing_spaces_match_id = 0
    endif
    let g:trailing_spaces_enabled = 0
    echo "Trailing spaces highlighting disabled"
  else
    " Enable trailing spaces highlighting
    let g:trailing_spaces_match_id = matchadd('ErrorMsg', '\s\+$')
    let g:trailing_spaces_enabled = 1
    echo "Trailing spaces highlighting enabled"
  endif
endfunction

" Auto-highlight trailing spaces on startup and text changes
augroup TrailingSpaces
  autocmd!
  autocmd BufEnter * if g:trailing_spaces_enabled | let g:trailing_spaces_match_id = matchadd('ErrorMsg', '\s\+$') | endif
  autocmd TextChanged,TextChangedI * if g:trailing_spaces_enabled && g:trailing_spaces_match_id == 0 | let g:trailing_spaces_match_id = matchadd('ErrorMsg', '\s\+$') | endif
augroup END

" Map the toggle function to \+F1
nnoremap \<F1> :call ToggleTrailingSpaces()<CR>






" TODO:
"- How to remove item from quickfix list using `dd`?
"
"https://stackoverflow.com/a/48817071
"" When using `dd` in the quickfix list, remove the item from the quickfix list.
"function! RemoveQFItem()
"  let curqfidx = line('.') - 1
"  let qfall = getqflist()
"  call remove(qfall, curqfidx)
"  call setqflist(qfall, 'r')
"  execute curqfidx + 1 . "cfirst"
"  :copen
"endfunction
":command! RemoveQFItem :call RemoveQFItem()
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
"autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>

"highlight DiffAdd guibg=green
"highlight DiffDelete guibg=red
"highlight DiffChange guibg=orange
"highlight DiffText guibg=yellow
