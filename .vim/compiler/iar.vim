" ---- Beginning of ${vimfiles}/compiler/iar.vim ----
" Compiler:     IAR 5.20
" Maintainer:   Julien Lefrique
" Last Change:  2012-02-22

if exists("current_compiler")
  finish
endif
let current_compiler = "iar"

" errorformat matches compiler errors and warnings like:
" C:\my\path\myfile.c(line) : Error[Pe165]: some information
"
" Also matches linker errors like:
" Error[e46]: some information
"
CompilerSet errorformat=
  \%f(%l)\ :\ %trror[Pe%n]:\ %m,
  \%f(%l)\ :\ %tarning[Pe%n]:\ %m,
  \%trror[e%n]:\ %m

" ---- End of Vim compiler file ----
"
