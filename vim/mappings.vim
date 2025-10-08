" Mappings and mapped custom functions

" map CTRL_T to toggle outline view
nnoremap <silent><nowait> <C-t>  :call ToggleOutline()<CR>
function! AdjustOutlineWidth(timerid)
    let winid = coc#window#find('cocViewId', 'OUTLINE')
    if winid != -1
        call coc#window#adjust_width(winid)
    endif
endfunction
function! ToggleOutline() abort
    let winid = coc#window#find('cocViewId', 'OUTLINE')
    if winid == -1
      call CocActionAsync('showOutline')
      call timer_start(100, 'AdjustOutlineWidth')
    else
      " note: using win_execute instead of coc#window#close because the latter
      " reopens the outline window when switching back to the buffer
      call win_execute(winid, 'close')
    endif
endfunction

" toggle mouse control between terminal and vim
noremap <silent><F2> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>
inoremap <silent><F2> <ESC>:let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>l
function! ShowMouseMode()
    if (&mouse == 'a')
        echo "vim mouse"
    else
        echo "X11 mouse"
    endif
endfunction

function ConfigureMarkdownMappings()
    " requires vim-surround
    vmap <buffer> <leader>k S]f]a()<Esc>i
endfunction
au FileType markdown :call ConfigureMarkdownMappings()

" Inline Temp Variable refactoring
" this will inline the first reference to the variable assigned in
" current line. Use dot to repeat the substitution.
nnoremap <Plug>InlineVariable 0*Nf=w"rDddcgn<c-r>r<esc>$
nmap <leader>iv <Plug>InlineVariable

" stolen from Gary Bernhardt's vimrc:
function! ExtractVariable()
    let name = input("Variable name: ")
    if name == ''
        return
    endif
    " Enter visual mode (not sure why this is needed since we're already in
    " visual mode anyway)
    normal! gv

    " Replace selected text with the variable name
    exec "normal c" . name
    " Define the variable on the line above
    exec "normal! O" . name . " = "
    " Paste the original selected text to be the variable value
    normal! $p
endfunction
vnoremap <leader>ev :call ExtractVariable()<cr>

" in a terminal, <esc> will go to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap <leader> <space>
