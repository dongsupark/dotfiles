" ==================================================================
" ~/.vimrc
" Author:       Dongsu Park <dpark AT posteo.net>
" ==================================================================
version 7.0

" ============================
" Loading general setup files
" ============================

if has("unix")
    " Source the setup file for all users:
    let FILE=expand("~/.vimrc.foralls")
    if filereadable(FILE)
        exe "source " . FILE
    endif
endif

" ==============
" General settings
" ==============

colorscheme desert
filetype on
filetype plugin on
filetype indent on
syntax on

:if &term == "xterm"
:  set t_kb=
:  fixdel
:endif

" ===================
" Setting of Options
" ===================

set noautoindent
set background=dark
set backspace=indent,eol,start
set nocindent
set nocp
set cinoptions=:0,#0
set expandtab
set fileencodings=utf-8,iso-8859-1
set hlsearch
set indentkeys=0{,0},0),:,!^F,o,O,e
set nojoinspaces
set linebreak
set magic
set ruler
set shiftwidth=4
set nosmartindent
set smarttab
set noshowcmd
set noshowmatch
set tabstop=4
set wildmenu
set wrap

" this mapping is very very crucial. otherwise, the buffer and file
" explorer area will keep jumping all over the place. very very annoying
" if that happens.
if has(":vsplit")
    set ea
    set eadirection=ver
end

" ==============
" Autocommands
" ==============

autocmd FileType sh set noexpandtab|set tabstop=8|set shiftwidth=8|set autoindent|set smartindent
augroup dotconfig
    autocmd BufRead,BufNewFile .* set noexpandtab|set tabstop=8|set shiftwidth=8|set autoindent|set smartindent
augroup END

augroup cfile
    " default settings
    autocmd BufRead,BufNewFile *.{c,h,cpp,hx} set expandtab|set tabstop=4|set shiftwidth=4|set textwidth=78|set cindent
    " kernel source files
    autocmd BufRead,BufNewFile */linux*/*.{c,h,cpp,hx} set noexpandtab|set tabstop=8|set shiftwidth=8
    " systemd source files
    autocmd BufRead,BufNewFile */systemd*/*.{c,h,cpp,hx} set tabstop=8|set shiftwidth=8
    " qemu source files
    autocmd BufRead,BufNewFile */qemu*/*.{c,h,cpp,hx} set tabstop=4|set shiftwidth=4
augroup END

autocmd FileType diff set noexpandtab|set tabstop=8|set shiftwidth=8|set autoindent|set smartindent
autocmd FileType html set isk+=:,/,~
autocmd FileType java set expandtab|set autoindent|set smartindent
autocmd FileType json set expandtab|set tabstop=2|set shiftwidth=2|set autoindent|set smartindent
autocmd FileType make set noexpandtab|set tabstop=8|set shiftwidth=8|set autoindent|set smartindent
autocmd FileType perl set expandtab|set autoindent|set nosmartindent
autocmd FileType python set expandtab|set autoindent|set nosmartindent
autocmd FileType ruby set expandtab|set autoindent|set nosmartindent
autocmd FileType toml set expandtab|set tabstop=2|set shiftwidth=2|set autoindent|set smartindent
autocmd FileType yaml set expandtab|set tabstop=2|set shiftwidth=2|set autoindent|set smartindent

" ==============
" Autocommands Group
" ==============

augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

" ===================
" Functions
" ===================

function s:FindFile(file)
    let curdir = getcwd()
    let found = curdir
    while !filereadable(a:file) && found != "/"
        cd ..
        let found = getcwd()
    endwhile
    execute "cd " . fnameescape(curdir)
    return found
endfunction

" ===================
" Cscope
" ===================

map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
map <C-\>s :cs find 0 <C-R>=expand("<cword>")<CR><CR>

map <c-w><c-b> :GotoBufExplorerWindow<cr>
map <c-w><c-f> :GotoFileExplorerWindow<cr>

"I've installed the Enhanced Commentify Plugin of vim!
let g:EnhCommentifyUseAltKeys = 'Yes'

" ===================
" Ctags
" ===================

let $CTAGS_DIR = s:FindFile("tags")
let $CTAGS_DB = $CTAGS_DIR."/tags"
if filereadable($CTAGS_DB)
    set tags+=$CTAGS_DB
endif

command -nargs=0 Ctags !ctags -R &

" ===================
" EnhancedCommentify
" ===================

let ECFILE="~/.vim/plugin/EnhancedCommentify.vim"
if filereadable(ECFILE)
    source ECFILE
endif

nmap <silent> <unique> <F2> <Plug>Traditionalj
imap <silent> <unique> <F2> <Esc><Plug>Traditionalji
vmap <silent> <unique> <F2> <Plug>Traditional

nmap <silent> <unique> <C-E> <Plug>Traditionalj
imap <silent> <unique> <C-E> <Esc><Plug>Traditionalji
vmap <silent> <unique> <C-E> <Plug>Traditional

map <F7> <End>a<Tab>/*<SPACE><SPACE>*/<ESC><LEFT><LEFT>
imap <F7> <ESC><End>a<Tab>/*<SPACE><SPACE>*/<ESC><LEFT><LEFT>i

map <F8> i<TAB><ESC><RIGHT>
imap <F8> <TAB><ESC><RIGHT>i

nmap <F10> :TagBarToggle<CR>


inoremap <ESC> <ESC>:set imdisable<CR>
nnoremap i :set noimd<CR>i
nnoremap I :set noimd<CR>I
nnoremap a :set noimd<CR>a
nnoremap A :set noimd<CR>A
nnoremap o :set noimd<CR>o
nnoremap O :set noimd<CR>O

" pathogen
source ~/.vim/autoload/pathogen.vim
execute pathogen#infect()

" ===================
" Fugitive
" ===================

let FTFILE="~/.vim/plugin/fugitive.vim"
if filereadable(FTFILE)
    source FTFILE
endif

" ======================
" Vim plug
" ======================

call plug#begin('~/.vim/plugged')

" plug vim-go
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go'
Plug 'jodosha/vim-godebug'

call plug#end()

" ======================
" vim-go mappings
" ======================

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)

au FileType go nmap <C-]>  <Plug>(go-def)
au FileType go nmap <C-\>s <Plug>(go-callers)

au FileType qf call AdjustWindowHeight(5, 10)
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

let g:mapleader=","

let g:go_fmt_autosave = 1
let g:go_def_mode = 'godef'

let g:go_list_type = 'quickfix'

let g:syntastic_go_checkers = 1

" ======================
" rust
" ======================
let g:rustfmt_autosave = 1

set hidden
let g:racer_cmd = '~/.cargo/bin/racer'

au FileType rust nmap <leader>r <Plug>(RustRun)
au FileType rust nmap <leader>b <Plug>(RustBuild)
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

au FileType rust nmap <C-]>  <Plug>(rust-def)
