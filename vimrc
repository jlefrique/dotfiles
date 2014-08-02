" Vim configuration file

" Activate pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

set nocompatible

syntax on
filetype plugin indent on

" Global settings
set incsearch
set modelines=0
set hidden
set autoread                       " Update buffer when file changes elsewhere
set novisualbell
set ttyfast
set number                         " Display line number
set history=1000

" Suffixes : these are the files we are unlikely to edit
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.out,.toc

" Visual aspect
colorscheme xoria256

" After setting the xoria256 colorscheme, the background is incorrectly reset
" to 'light', this is a workaround to set it to 'dark'.
syntax off
set background=dark
syntax enable

set ruler                          " Show cursor position at all times
set textwidth=0                    " Don't wrap words by default
set backspace=indent,eol,start
set showmatch
set showmode
set showcmd

" Nice statusbar
set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=0x%-8B\                      " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" GUI Settings
if has("gui_running")
  set guioptions-=m " Remove menu bar
  set guioptions-=T " Remove toolbar
  set guioptions-=r " Remove right-hand scroll bar
  set guioptions-=L " Remove left-hand scroll bar when vertical split
endif

set nostartofline
set ls=2
let mysyntaxfile = "~/.vimsyntax.vim"

set iskeyword=@,48-57,_,192-255,-

" Default indentation and coding style
set shiftwidth=2
set tabstop=2
set expandtab
set softtabstop=2

" Highlight extra whitespaces
highlight ExtraWhitespace ctermbg=darkred guibg=darkgreen
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" Highlight column 80
if exists('+colorcolumn')
  highlight ColorColumn ctermbg=233 guibg=#121212
  set colorcolumn=80
endif

" Search settings
set incsearch
set smartcase
set infercase
set hlsearch
set showfulltag

" Scrolling
set scrolloff=3
set sidescrolloff=2

" Tab complete menu
set wildmode=longest:full
set wildmenu
set wildignore=*.o,*.a,*.so,*~,*.swp,*.pyc,*.dll,tags

" Key mappings
nmap :W :w
nmap :Q :q
nmap <Leader>q :nohlsearch<CR>
" Move up/down a single row on the screen instead of on a linewise basis.
nnoremap j gj
nnoremap k gk
" Make Y consistent with C and D. See :help Y.
nnoremap Y y$
" Cycle and fly through buffers
nmap <tab> :bn<CR>
nmap <s-tab> :bp<CR>
nnoremap <Leader>l :ls<CR>:b<Space>

" Search in multiple files
map <F2> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
map <Leader>x vawy:! grep <C-R>" .* *<CR>

" Filetype specific configuration
if has("autocmd")
  augroup vimrc
  au!
  au FileType make setlocal noexpandtab

  au BufNewFile,BufRead */JP/*MCU*.[ch] call s:MyJPSettings()
  au BufNewFile,BufRead */JP/MainMCU*.[ch] compiler iar
  au BufNewFile,BufRead */JP/MonitorMCU*.[ch] compiler rcstm8

  au FileType c,cpp call s:MyCSettings()
  au FileType python call s:MyPythonSettings()
  au FileType java call s:MyJavaSettings()
  au FileType gitconfig call s:MyGitConfigSettings()
  au FileType gitcommit setlocal tw=72

  au BufRead .letter,/tmp/mutt*,*.txt,.signature*,signature*
    \ call s:MyMuttSettings()
  au BufRead *.tex call s:MyTexSettings()
  au BufRead *linux/*.c call s:MyKernelSettings()
  au BufNewFile,BufRead *.viki setfiletype viki

  " Enable modeline with vimoutliner files.
  au BufRead *.otl,*.otl.gpg setlocal modeline modelines=1
  augroup END
endif

" For JP code
function! s:MyJPSettings()
  syn keyword cType uint8 uint16 uint32 int8 int16 int32 boolean
  set wildignore+=*.r44,*.d43
  set makeprg=echo\ '\\n***\ Building...';\ paver\ build\ $*
endfunction

" For kernel code
function! s:MyKernelSettings()
  setlocal ts=8
  setlocal softtabstop=8
  setlocal shiftwidth=8
  setlocal noexpandtab
endfunction

" For Git
function! s:MyGitConfigSettings()
  setlocal noexpandtab
endfunction

" For LaTeX
function! s:MyTexSettings()
  setlocal tw=80
endfunction

" For C
function! s:MyCSettings()
  "setlocal formatoptions=croql
  "setlocal cindent
  setlocal comments=sr:/*,mb:*,el:*/,://
  "setlocal noexpandtab
  setlocal expandtab
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal autoindent
  setlocal smartindent
endfunction

" For Python
function! s:MyPythonSettings()
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal shiftwidth=4
  setlocal expandtab
  setlocal autoindent
  "setlocal textwidth=80
endfunction

" For Java
function! s:MyJavaSettings()
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal shiftwidth=4
  setlocal expandtab
  setlocal autoindent
endfunction

" For email writing
function! s:MyMuttSettings()
  setlocal textwidth=72
  setlocal foldmethod=manual
endfunction

" Spelling settings
let b:myLang=0
let g:myLangList=["nospell","en","fr"]
function! ToggleSpell()
  let b:myLang=b:myLang+1
  if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
  if b:myLang==0
    setlocal nospell
  else
    execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
  endif
  echo "spell checking language:" g:myLangList[b:myLang]
endfunction
nmap <silent> <F7> :call ToggleSpell()<CR>

" Change paste mode
nnoremap <F10> :set paste! <Bar> :set paste?<CR>

" Tag List plugin
nnoremap <F4> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1       " Display the taglist on the right

" Python-mode plugin
let g:pymode_folding = 0

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)
