" Mappings and mapped custom functions

" navigate tabs with <shift-hl>
map <S-H> gT
map <S-L> gt

" shortcuts for expand-region plugin
vmap v     <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" nerdtree toggle shortcut
nnoremap <Leader>n :NERDTreeToggle<CR>


" maps <space> to default leader - this works better
" than setting mapleader because it works with showcmd
map <space> \

" maps %% to expand path of current file directory in cmd mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" visually select the text that was last edited/pasted
nmap gV `[v`]

" keep my sanity whenever I type :Wq or :W
cab W w
cab Q q
cab Wq wq
cab wQ wq
cab WQ wq
cab Qa qa
cab QA qa

" folding
nmap <leader>l za
nmap <leader>f :set foldenable!<cr>

" save using <C-S>
command! -nargs=0 -bar Update if &modified
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
nnoremap <silent> <C-S> :<C-u>Update<CR>
inoremap <silent> <C-S> <Esc>:<C-u>Update<CR>a

" exit using <C-Q>
nnoremap <silent> <C-Q> :qa<CR>

"windows:
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" quick no-regex search
noremap <C-f> /\V

" makes <C-c> and <C-3> equivalent to Esc
inoremap <C-c> <esc>
noremap <C-3> <esc>

" goes to previous file pressing space twice
nnoremap <leader><space> <c-^>

" disable highlight search when pressing ENTER on normal mode
nnoremap <CR> :nohlsearch<CR><CR>

" copying from clipboard:
vnoremap <leader>y "+y
nnoremap <leader>y "+y

" paste from clipboard
vnoremap <leader>p "+p
noremap <leader>p "+p
noremap <leader>P "+P

" mappings for quoting words
map <leader>qw ysiw`
map <leader>qW ysiW`

" TODO: wrap this properly, avoid overwriting buffer when error
function! JsonFormat() range
    exec 'normal! :' + a:firstline . ',' . a:lastline . '!python -mjson.tool'
endfunction
nnoremap <leader>j :%call JsonFormat()<cr>
vnoremap <leader>j :call JsonFormat()<cr>


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

" use <leader>t for run tests, :TestCmd {test command} to customize test command
" TODO: show current test command, better history (consider wrap in plugin)
function! RemapTestCmd(...)
    if a:0 ==# 1 && a:1 !=# ''
        let testcmd = a:1
    else
        let testcmd = input("Test command: ")
    endif
    exec 'noremap <leader>t :!clear; ' . testcmd . '<cr>'
endfunction
call RemapTestCmd('make test')
command! -nargs=? TestCmd :call RemapTestCmd('<args>')

au FileType python call RemapTestCmd('py.test -s -v')
au FileType elixir call RemapTestCmd('mix test')

" access help using devdocs.io -- TODO: write plugin?
command! -nargs=? DevDocs :call system('xdg-open http://devdocs.io/#q=<args> &')
au FileType python,ruby,javascript,html,php,eruby,coffee
            \ nnoremap <buffer> K
            \ :exec "DevDocs " . fnameescape(expand('<cword>'))<CR>


function! InsertCurrentPosition(pos, text)
"******************************************************************************
"* PURPOSE:
"   Insert a:text at a:pos.
"* ASSUMPTIONS / PRECONDITIONS:
"   Buffer is modifiable.
"* EFFECTS / POSTCONDITIONS:
"   Changes the buffer.
"* INPUTS:
"   a:pos   [line, col]; col is the 1-based byte-index.
"   a:text  String to insert.
"* RETURN VALUES:
"   Flag whether the position existed (inserting in column 1 of one line beyond
"   the last one is also okay) and insertion was done.
"******************************************************************************
    let [l:lnum, l:col] = a:pos
    if l:lnum > line('$') + 1
    return 0
    endif

    let l:line = getline(l:lnum)
    if l:col > len(l:line) + 1
    return 0
    elseif l:col < 1
    throw 'Insert: Column must be at least 1'
    elseif l:col == 1
    return (setline(l:lnum, a:text . l:line) == 0)
    elseif l:col == len(l:line) + 1
    return (setline(l:lnum, l:line . a:text) == 0)
    elseif l:col == len(l:line) + 1
    return (setline(l:lnum, l:line . a:text) == 0)
    endif
    return (setline(l:lnum, strpart(l:line, 0, l:col - 1) . a:text . strpart(l:line, l:col - 1)) == 0)
endfunction

command! -nargs=0 GenerateId :call InsertCurrentPosition([line('.'), col('.')],
            \ system("echo -n $(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 20 | head -1)"))
