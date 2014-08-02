" Add ranger as a file chooser in vim
" 
" If you add this function and the key binding to the .vimrc, ranger can be
" started using the keybinding "<Leader>r".  Once you select a file by pressing
" enter, ranger will quit again and vim will open the selected file.

fun! RangerChooser()
    exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun
nnoremap <Leader>r :call RangerChooser()<CR>
nnoremap <F3> :call RangerChooser()<CR>
