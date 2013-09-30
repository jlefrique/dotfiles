" ---- Beginning of ${vimfiles}/compiler/ride.vim ----
" Compiler:     Ride 7
" Maintainer:   Julien Lefrique
" Last Change:  2013-09-24

if exists("current_compiler")
  finish
endif
let current_compiler = "ride"

" errorformat matches compiler errors and warnings like:
"
" *** WARNING C090 IN LINE 223 OF C:\my\path\myfile.c : message
"
" Also matches linker errors of the form:
" ***ERROR 107:some information
"
CompilerSet errorformat=
  \*\*\*\ %tRROR\ C%n\ IN\ LINE\ %l\ OF\ %f\ :\ %m,
  \*\*\*\ %tARNING\ C%n\ IN\ LINE\ %l\ OF\ %f\ :\ %m,
  \*\*\*%tRROR\ %n:\ %m

" ---- End of Vim compiler file ----
"
