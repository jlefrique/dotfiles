" Add dmenu as a file chooser in vim

function! DmenuOpen(cmd)
  let fname = system("dmenu_edit.sh")
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fnameescape(fname)
endfunction
nnoremap <Leader>t :call DmenuOpen("e")<CR>

