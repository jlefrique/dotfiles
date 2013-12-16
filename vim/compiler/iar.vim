" ---- Beginning of ${vimfiles}/compiler/iar.vim ----
" Compiler:     IAR 5.20
" Maintainer:   Julien Lefrique
" Last Change:  2013-12-16

if exists("current_compiler")
  finish
endif
let current_compiler = "iar"

" errorformat matches compiler errors and warnings like:
" C:\my\path\myfile.c(line) : Error[Px165]: some information
"
" Also matches linker errors like:
" Error[x46]: some information
"
CompilerSet errorformat=
  \%f(%l)\ :\ %trror[P%.%#%n]:\ %m,
  \%f(%l)\ :\ %tarning[P%.%#%n]:\ %m,
  \%trror[%.%#%n]:\ %m

" ---- End of Vim compiler file ----
"
