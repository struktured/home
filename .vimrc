execute pathogen#infect()
syntax on
filetype plugin indent on

set shiftwidth=2
syn on
colorscheme torte 
set guifont=Liberation\ Mono\ 14
set nu!
set list
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
execute "set rtp+=" . g:opamshare . "/merlin/vimbufsync"
execute ":source " . g:opamshare . "/vim/syntax/ocp-indent.vim"
let g:syntastic_ocaml_checkers = ['merlin']

filetype indent on
filetype plugin on
au BufRead,BufNewFile *.ml,*.mli,*.mlt compiler ocaml

            
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## ecf1325a5957f0f1480f09db0b971264 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/carm/.opam/4.02.3/share/vim/syntax/ocp-indent.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
" ## added by OPAM user-setup for vim / ocp-index ## 37127f59fff035feb830f8a3b54c5855 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-index") == 0
  source "/home/carm/.opam/4.02.2/share/vim/syntax/ocpindex.vim"
endif

if count(s:opam_available_tools,"ocp-index") == 0
  source "/home/carm/.opam/4.02.2/share/vim/syntax/ocpindex.vim"
endif

if count(s:opam_available_tools,"ocp-index") == 0
  source "/home/carm/.opam/4.02.2/share/vim/syntax/ocpindex.vim"
endif

if count(s:opam_available_tools,"ocp-index") == 0
  source "/home/carm/.opam/4.02.2/share/vim/syntax/ocpindex.vim"
endif

