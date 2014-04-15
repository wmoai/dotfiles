set nocompatible
set backspace=2
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'L9'

NeoBundle 'commentToggle'
NeoBundle 'FuzzyFinder'

NeoBundle 'php.vim'
NeoBundle 'phtml.vim'
NeoBundle 'EasyHtml.vim'
NeoBundle 'yaml.vim'
NeoBundle 'python.vim'

NeoBundle 'w0ng/vim-hybrid'

" =====================================================
"  neocomplcache
" =====================================================
NeoBundle 'Shougo/neocomplcache'
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" =====================================================
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" =====================================================
"  simple-javascript-indenter
" =====================================================
NeoBundle 'jiangmiao/simple-javascript-indenter'
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" =====================================================
"  vim-node 
" =====================================================
NeoBundle 'moll/vim-node'
autocmd User Node
  \ if &filetype == "javascript" |
  \   nmap <buffer> gf <Plug>NodeTabGotoFile |
  \ endif

NeoBundle 'scrooloose/syntastic'


filetype plugin indent on

au QuickfixCmdPost vimgrep cw
set noswapfile

"=== indent ===
set autoindent smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

"=== search ===
set wrapscan
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <silent> gh :let @/=''<CR>

"=== display ===
let g:hybrid_use_iTerm_colors = 1
colorscheme hybrid
set showmatch
set showcmd
set number
set wrap
set notitle
set laststatus=2
highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=gray
syntax on

"--------------------------------------------
"  encoding
"--------------------------------------------
if has('unix')
    set fileformat=unix
    set fileformats=unix,dos,mac
    set fileencoding=utf-8
    set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
    set termencoding=
elseif has('win32')
    set fileformat=dos
    set fileformats=dos,unix,mac
    set fileencoding=utf-8
    set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
    set termencoding=
endif

"--------------------------------------------
" PHP function listing
"--------------------------------------------
nnoremap <silent> func :call Gfunc()<CR>
function! Gfunc()
  if &filetype=='php'
    vimgrep /^\s*\(public\|protected\|private\)\=\s*\(static\)\=\s*function\s*(*/ % | cw
  elseif &filetype=='vim'
    vimgrep /function!\= *\(*\)/ % | cw
  else
    echo "unknown filetype"
  endif
endfunction

"--------------------------------------------
" PHP Lint 
nmap ,l :call PHPLint()<CR>
"--------------------------------------------
"  PHPLint
function PHPLint()
    let result = system( &ft . ' -l ' . bufname(""))
    echo result
endfunction


