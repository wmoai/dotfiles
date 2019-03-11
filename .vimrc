set nocompatible
set backspace=2
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'wincent/command-t'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}


Plugin 'L9'

Plugin 'commentToggle'
Plugin 'fatih/vim-go'
Plugin 'php.vim'
Plugin 'phtml.vim'
Plugin 'EasyHtml.vim'
Plugin 'yaml.vim'
Plugin 'python.vim'
Plugin 'elzr/vim-json'
Plugin 'ctrlpvim/ctrlp.vim'

" =====================================================
"  javascript
" =====================================================
Plugin 'pangloss/vim-javascript'
" =====================================================

" =====================================================
"  typescript
" =====================================================
Plugin 'leafgarland/typescript-vim'
autocmd BufRead,BufNewFile *.ts,*.tsx set filetype=typescript
" =====================================================

" =====================================================
"  pug
" =====================================================
Plugin 'digitaltoad/vim-pug'
au BufRead,BufNewFile,BufReadPre *.jade,*.pug set filetype=pug
autocmd FileType pug    setlocal sw=4 sts=4 ts=4 et
" =====================================================

" =====================================================
"  coffee script
" =====================================================
Plugin 'kchmck/vim-coffee-script'
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" autocmd FileType coffee    setlocal sw=2 sts=2 ts=2 et
" autocmd BufWritePost *.coffee silent make!
" autocmd QuickFixCmdPost * nested cwindow | redraw!
" nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h
" =====================================================

Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'kentaroi/cocoa.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'kannokanno/previm'
Plugin 'tyru/open-browser.vim'

" =====================================================
"  neocomplcache
" =====================================================
Plugin 'Shougo/neocomplcache'
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
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'

" =====================================================
"  vim-node 
" =====================================================
Plugin 'moll/vim-node'
autocmd User Node
  \ if &filetype == "javascript" |
  \   nmap <buffer> gf <Plug>NodeTabGotoFile |
  \ endif

" =====================================================
"  ale
" =====================================================
Plugin 'w0rp/ale'
let b:ale_fixers = {'javascript': ['eslint']}
let b:ale_fixers = {'typescript': ['eslint']}
" =====================================================


call vundle#end()
filetype plugin indent on

noremap <C-j> <esc>
noremap! <C-j> <esc>

au QuickfixCmdPost vimgrep cw
set noswapfile

"=== search ===
set wrapscan
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <silent> gh :let @/=''<CR>

"=== indent ===
set autoindent smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set list
set listchars=tab:>-

"=== display ===
let g:hybrid_use_iTerm_colors = 1
set background=dark
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


