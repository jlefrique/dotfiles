" Strip  trailing whitespaces

function! StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  " Restore previous search history and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
