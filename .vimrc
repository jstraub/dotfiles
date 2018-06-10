set nocompatible            "Use Vim settings, rather then Vi settings (much better!).
" ------------- Vundle stuff
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle [required! ]
Bundle 'VundleVim/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'altercation/vim-colors-solarized'
Bundle 'junegunn/seoul256.vim'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-dispatch'
Bundle 'scrooloose/syntastic'
Bundle 'rhysd/vim-clang-format'
Bundle 'junegunn/goyo.vim'
call vundle#end()
filetype plugin indent on   " required!

set rtp+=~/dotfiles/3rdparty/fzf

"YouCompleteMe looks into tag files
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
" when to clode preview of function window
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py" 
let g:ycm_confirm_extra_conf = 0

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ClangFormat
imap <c-l> <Esc>:ClangFormat<CR>
map <c-l> :ClangFormat<CR>
let g:clang_format#code_style = "google"
let g:clang_format#style_options = {
      \ "DerivePointerAlignment" : "false",
      \ "PointerAlignment" : "Left",
      \ "Standard" : "C++11"}

colorscheme distinguished
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set shiftwidth=2            " I like 2 spaces for indenting
set tabstop=2               " I like 2 stops
set expandtab               " Spaces instead of tabs
set autoindent              " Always  set auto indenting on
set selectmode=mouse        " select when using the mouse
set textwidth=80
filetype plugin indent on   " Automatically detect file types.
syntax on                   " syntax highlighting
set background=dark         " Assume a dark background
set spelllang=en_us,de_de
set spell
syntax spell toplevel
set incsearch   " incremental search 
set ignorecase
set smartcase
set hlsearch    " highlight search 
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=5000	" keep 50 lines of command line history
set showcmd		    " display incomplete commands
" makes sure that all windows are always the same size when vim gets
" resized.
autocmd VimResized * wincmd =
autocmd FileType tex setlocal commentstring=%\ %s
autocmd FileType cpp setlocal commentstring=\/\/\ %s

" some random optimizations
map q: :q      
" remap the moveing keys to allow movement within long lines
nnoremap k gk
nnoremap j gj
nnoremap 0 g0
nnoremap $ g$
nnoremap ^ g^
" press to allow pasting - makes sure the pasted text is formated correctly
set pastetoggle=<F2>
" leader key is space
let mapleader = "\<Space>"
" open file using fzf using " e"
nnoremap <C-e> :FZF<CR>
nnoremap <Leader>e :FZF<CR>
" save to file with " w"
nnoremap <Leader>w :w<CR>
" replace selected word
vmap <Leader>r "sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/
" search for visually highlighted text
vmap // y/<C-R>"<CR>       
" move in by 2 spaces
vmap t :s/^/  /g<CR>
" move back by 2 spaces
vmap T :s/^  //g<CR>

" visual mode via "  "
nmap <Leader><Leader> V
" expand region by pressing v
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" copy past to system clipboard with " p" and " y"
vmap <Leader>y "*y
vmap <Leader>d "*d
nmap <Leader>p "*p
nmap <Leader>P "*P
vmap <Leader>p "*p
vmap <Leader>P "*P
" support for German
imap ;ue ü
imap ;oe ö
imap ;ae ä
imap ;Ae Ä
imap ;Oe Ö
imap ;Ue Ü
imap ;ss ß

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Dispatch
nnoremap <silent> <F5> :Dispatch<CR>
" increasing and decreasing height of windows
map - <C-W>-
map + <C-W>+

" TMUX
" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
