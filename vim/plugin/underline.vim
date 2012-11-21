" Underline function.
"
" This function underline with a given pattern ('-' by default). This
" is useful when writing text in a markup language (Markdown,
" reStructuredText...).
"
" Note that yypVr- also works well.

function! s:Underline(chars)
  let chars = empty(a:chars) ? '-' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)
