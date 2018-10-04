set shortmess+=A

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdtree'
"Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rgrinberg/vim-ocaml'
Plug 'jlanzarotta/bufexplorer'
Plug 'Shougo/deoplete.nvim'
Plug 'dkprice/vim-easygrep'
Plug 'neomake/neomake'
Plug 'vim-airline/vim-airline'
"Plug 'terryma/vim-multiple-cursors'
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'zhaocai/GoldenView.Vim'
"Plug 'blindFS/vim-taskwarrior'
Plug 'pangloss/vim-javascript'
Plug 'reasonml-editor/vim-reason-plus'
call plug#end()

"let g:goldenview__enable_default_mapping = 0
" 1. split to tiled windows
"nmap <silent> <C-L>  <Plug>GoldenViewSplit
" 3. jump to next and previous window
"nmap <silent> <C-N>  <Plug>GoldenViewNext

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set clipboard+=unnamedplus
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

"set foldmethod=indent
map <localleader>a :MerlinDocument<CR>
map <localleader>l :MerlinLocate<CR>
map <localleader>o :MerlinOccurrences<CR>
map <localleader>d :MerlinDestruct<CR>
map <localleader>tt :MerlinClearEnclosing<CR>
map <localleader>y :MerlinYankLatestType<CR>

" When writing a buffer (no delay).
call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 0)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 300)



" Easier moving around windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump =  0
let g:syntastic_aggregate_errors = 1
let g:deoplete#enable_at_startup = 1
let g:EasyGrepRecursive=1
let g:deoplete#enable_at_startup = 0
let g:ctrlp_max_depth=60
let g:ctrlp_max_files=0

set guicursor=
":set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
" custom commands: BEGIN
command TouchOn !xinput enable 11
command TouchOff !xinput disable 11
command Bright colorscheme morning
"command Dark colorscheme candy
command Dark colorscheme evolutionblack

set shiftwidth=2
set hidden
set smartindent
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

syn on
Dark
set nu!
set list
set expandtab
set maxmempattern=2000000
filetype indent on
filetype plugin on
au filetype ocaml setlocal expandtab
autocmd! BufWritePost * Neomake

set wildignore+=*/_build/*
set wildignore+=*/target/*

highlight colorcolumn ctermbg=GRAY
call matchadd('ColorColumn', '\%81v', 100)


"let g:neomake_ocaml_merlin_maker = {
    \ 'args': ['--verbose'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
"let g:neomake_ocaml_enabled_makers = ['merlin']

" ** START Custom Ocaml Setup START
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
execute "set rtp+=" . g:opamshare . "/merlin/vimbufsync"
" execute ":source " . g:opamshare . "/vim/syntax/ocp-indent.vim"
let g:syntastic_ocaml_checkers = ['merlin']

au BufRead,BufNewFile *.ml,*.mli,*.mlt compiler ocaml
" ** END Custom Ocmal Setup END

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

"function! OpamConfOcpIndex()
"  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
"endfunction
"let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')
let s:opam_packages = ["ocp-indent", "merlin"]
"let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## bc1bebc901a148b528f5f68d518153f8 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/cep1/.opam/4.03.0/share/vim/syntax/ocp-indent.vim"
endif

:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l
