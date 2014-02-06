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
NeoBundle 'vtreeexplorer'

NeoBundle 'php.vim'
NeoBundle 'phtml.vim'
NeoBundle 'EasyHtml.vim'
NeoBundle 'vim-javascript'
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

"縦分割
let g:treeExplVertical=1
"分割したウィンドウのサイズ
let g:treeExplWinSize=50

"--------------------------------------------
" 文字コード設定
"--------------------------------------------
if &encoding !=# 'utf-8'
  set encoding=japan
endif
if has('iconv')
   let s:enc_euc = 'euc-jp'
   let s:enc_jis = 'iso-2022-jp'
   if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
       let s:enc_euc = 'eucjp-ms'
       let s:enc_jis = 'iso-2022-jp-3'
   elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
       let s:enc_euc = 'euc-jisx0213'
       let s:enc_jis = 'iso-2022-jp-3'
   endif
   if &encoding ==# 'utf-8'
       let s:fileencodings_default = &fileencodings
       let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
       let &fileencodings = &fileencodings .','. s:fileencodings_default
       unlet s:fileencodings_default
   else
       let &fileencodings = &fileencodings .','. s:enc_jis
       set fileencodings+=utf-8,ucs-2le,ucs-2
       if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
           set fileencodings+=cp932
           set fileencodings-=euc-jp
           set fileencodings-=euc-jisx0213
           set fileencodings-=eucjp-ms
           let &encoding = s:enc_euc
           let &fileencoding = s:enc_euc
       else
           let &fileencodings = &fileencodings .','. s:enc_euc
       endif
   endif
   unlet s:enc_euc
   unlet s:enc_jis
endif
" utf-8優先
let &fileencodings = substitute(&fileencodings, 'utf-8', '_utf-8', 'g')
let &fileencodings = substitute(&fileencodings, 'cp932', 'utf-8', 'g')
let &fileencodings = substitute(&fileencodings, '_utf-8', 'cp932', 'g')

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


