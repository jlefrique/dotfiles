" ---- Beginning of ${vimfiles}/compiler/iar.vim ----
" Compiler:     IAR icc430 (version 5.20)
" Maintainer:   Julien Lefrique
" Last Change:  2012-02-22

if exists("current_compiler")
  finish
endif
let current_compiler = "iar"

" errorformat matches errors and warning like:
" C:\my\path\myfile.c(line) : Error[Pe165]: some information
CompilerSet errorformat=
  \%E%f(%l)\ :\ Error[Pe%n]:\ %m,
  \%W%f(%l)\ :\ Warning[Pe%n]:\ %m

" ---- End of Vim compiler file ----
"
