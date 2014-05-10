" Add dmenu as a file chooser in vim

function! DmenuOpen(cmd)
  let fname = system("dmenu_edit")
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fnameescape(StripNull(fname))
endfunction

function! StripNull(input)
  return substitute(a:input, '\%x00', '', '')
endfunction

nnoremap <Leader>t :call DmenuOpen("e")<CR>
