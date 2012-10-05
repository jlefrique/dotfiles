" Vim configuration file

" Activate pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Global settings
set incsearch
set modelines=0
set nocompatible
"set shell=sh
set hidden
" set foldmethod=indent
set autoread                       " Update buffer when file changes elsewhere
set novisualbell
set ttyfast
set number                         " Display line number

" Suffixes : these are the files we are unlikely to edit
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.out,.toc

" Visual aspect
colorscheme xoria256

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
filetype plugin indent on
syntax on

" Highlight extra whitespaces
highlight ExtraWhitespace ctermbg=darkred guibg=darkgreen
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" Highlight column 80
if exists('+colorcolumn')
  highlight ColorColumn ctermbg=233 guibg=#121212
  set colorcolumn=80
endif

" Highlight overlength
"highlight OverLength ctermbg=darkred guibg=darkgreen
"match OverLength /\%81v.\+/

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
set wildignore=*.o,*~,*.swp

" Comment/uncomment
map ,q 0i/* <ESC>A */<ESC>j
map ,Q 0xxx$xxxj

" Key mappings
nmap :W :w
nmap :Q :q
nmap q: :q
nmap <tab> :bn<CR>
nmap <s-tab> :bp<CR>

" Search in multiple files
map <F2> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
map ,x vawy:! grep <C-R>" .* *<CR>

" Filetype specific configuration
if has("autocmd")
  augroup vimrc
  au!
  au FileType make
    \ setlocal noexpandtab
  au BufNewFile,BufRead /*apache*
    \ setfiletype apache
  au BufNewFile,BufRead */JP/* call s:MyJPSettings()

  au FileType c,cpp call s:MyCSettings()
  au FileType python call s:MyPythonSettings()
  au FileType java call s:MyJavaSettings()
  au FileType gitconfig call s:MyGitConfigSettings()
  au FileType gitcommit setlocal tw=72

  au BufRead .letter,/tmp/mutt*,*.txt,.signature*,signature* call s:MyMuttSettings()
  au BufRead *.tex call s:MyTexSettings()
  au BufRead *linux/*.c call s:MyKernelSettings()
  au BufNewFile,BufRead *.viki
    \ setfiletype viki
  augroup END
endif

" For JP code
function! s:MyJPSettings()
  syn keyword cType uint8 uint16 uint32 int8 int16 int32 boolean
  compiler iar
  set wildignore+=*.r43,*.d43
  " Paver is used instead of Make.
  if has("win32")
    set makeprg=paver\ build
  elseif has("unix")
    " Converts Windows paths to Unix paths.
    set makeprg=paver\ build\ $*\ \\\|&\ iar_unix_path
  endif
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

" Underline function (yypVr- also works well).
function! s:Underline(chars)
  let chars = empty(a:chars) ? '-' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)

" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

" List all versionned files and pass them to dmenu
function! DmenuOpen(cmd)
  let fname = Chomp(system("{ git ls-files; svn list -R | grep -v \".*\/$\"; } 2>/dev/null | dmenu -i -l 20 -p " . a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction

" NEERDTree plugin
nnoremap <F3> :NERDTreeToggle<CR>

" Tag List plugin
nnoremap <F4> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1       " Display the taglist on the right

" Python-mode plugin
let g:pymode_folding = 0

" Alt-right/left to navigate forward/backward in the tags stack
map <M-Left> <C-T>
map <M-Right> <C-]>

" Open files quickly with dmenu
map <Leader>t :call DmenuOpen("e")<cr>
