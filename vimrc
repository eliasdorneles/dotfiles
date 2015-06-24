set nocompatible
filetype off

set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" tim pope's sensible defaults
Bundle "tpope/vim-sensible"

" TAB completes everything
Bundle "ervandew/supertab"

Bundle "godlygeek/tabular"
Bundle "pangloss/vim-javascript"

" IDE like file explorer -- haven't used it much since CtrlP
Bundle "scrooloose/nerdtree"

"Bundle "timcharper/textile.vim"
"Bundle "tpope/vim-cucumber"
Bundle "tpope/vim-fugitive"
"Bundle "tpope/vim-git"
"Bundle "tpope/vim-haml"
Bundle "tpope/vim-markdown"
"Bundle "tpope/vim-rails"

" tim pope's essentials:
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-rsi"

" XXX: do I need this? I think vim already ships with it
Bundle "tmhedberg/matchit"

"Bundle "vim-ruby/vim-ruby"


" post a gist directly from vim
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'

Bundle "tpope/vim-unimpaired"

" gc{motion} for toggle comments
Bundle "tomtom/tcomment_vim"

Bundle "tpope/vim-ragtag"

" Ctrl-P, Ctrl-P, Ctrl-P, Ctrl-P!
Bundle "kien/ctrlp.vim"

Bundle "tpope/vim-capslock"
Bundle "scrooloose/syntastic"
Bundle "othree/html5.vim"
Bundle "fatih/vim-go"

"Bundle "vim-scripts/groovyindent"
Bundle "derekwyatt/vim-scala"

" enables to search from visual selection (useful for weird strings)
Bundle "nelstrom/vim-visual-star-search"

" pep8 utils
Bundle "hynek/vim-python-pep8-indent"
Bundle "nvie/vim-flake8"

Bundle "mattn/emmet-vim"

" keeps split windows using golden ratio widths
Bundle "roman/golden-ratio"

" snipmante and dependencies:
Bundle "tomtom/tlib_vim"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "garbas/vim-snipmate"

Bundle "Glench/Vim-Jinja2-Syntax"

Bundle "jimenezrick/vimerl"

" sets up a channel between the current buffer and a tmux/screen session
" Bundle "jpalardy/vim-slime"

Bundle "majutsushi/tagbar"

" :Rename to rename file in current buffer
Bundle "danro/rename.vim"

" :Scratch to open scratch window
Bundle "mtth/scratch.vim"

" exchange with cx (motion or selection)
Bundle "tommcdo/vim-exchange"

" expand region
Bundle "terryma/vim-expand-region"

Bundle "sjl/clam.vim"
Bundle 'terryma/vim-multiple-cursors'

Bundle "tomasr/molokai"

Bundle 'joonty/vim-sauce'

Bundle 'bling/vim-airline'

Bundle 'editorconfig/editorconfig-vim'

Bundle 'kana/vim-textobj-user'
Bundle 'bps/vim-textobj-python'

Bundle 'kchmck/vim-coffee-script'

Bundle 'tmhedberg/SimpylFold'

Bundle 'davidbeckingsale/writegood.vim'

" PLUGIN CONFIGURATIONS:

" Configuring shortcuts for expand-region plugin
vmap v     <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" nerdtree toggle shortcut
nnoremap <Leader>n :NERDTreeToggle<CR>

" uses Ctrl-Space for emmet expanding
let g:user_emmet_expandabbr_key = '<Nul>'

let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 0 " disabled b/c weird chars in output

" don't let golden-ratio resize tagbar window
let g:golden_ratio_exclude_nonmodifiable = 1

" CtrlP plugin mappings
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
            \ . '|bower_components|node_modules|build|_build'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_use_caching = 0

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" keep syntastic minimally annoying
let g:syntastic_enable_signs=0
let g:syntastic_python_checkers=['flake8', 'pylint']
let g:syntastic_mode_map = {
            \ "mode": "active",
            \ "active_filetypes": ["ruby", "php", "python", "javascript"],
            \ "passive_filetypes": ["puppet", "java"] }

let g:flake8_max_line_length=100

" don't fold docstrings
let g:SimpylFold_fold_docstring = 0


" MY CUSTOMIZATIONS:
set hlsearch

" setup swap file dir
silent :!mkdir -p /tmp/.vim-swap
set dir=/tmp/.vim-swap

" disables mouse
set mouse=

set scrolloff=2
set pastetoggle=<F10>
set modeline
set shiftwidth=4 tabstop=4 expandtab

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" maps <space> to default leader - this works better
" than setting mapleader because it works with showcmd
map <space> \

" maps %% to expand path of current file directory in cmd mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" visually select the text that was last edited/pasted
nmap gV `[v`]

" allows Alt to be used in terminal:
" http://stackoverflow.com/a/10216459/149872
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw

set ttimeout ttimeoutlen=50

" move a line of text using Alt+[jk]
nnoremap <M-j> mz:m+<cr>`z
nnoremap <M-k> mz:m-2<cr>`z
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" keep my sanity whenever I type :Wq or :W
cab W w
cab Q q
cab Wq wq
cab wQ wq
cab WQ wq

" giving folding a second chance
set nofoldenable
nmap <leader>l za
nmap <leader>f :set foldenable!<cr>

if has("gui_running")
    set guifont=Monospace\ 12
    set guioptions=aegiclA
    set lines=40 columns=80
endif

augroup highlight_annoying_whitespace_at_eol
    au BufNewFile,BufRead * syntax match annoyingwhitespace '\s\+$' |
                \ highlight annoyingwhitespace ctermbg=red
augroup END

" Grails:
au BufNewFile,BufRead *.gsp set ft=jsp

" Erlang:
au BufNewFile,BufRead rebar.config set ft=erlang
au BufNewFile,BufRead *.app.src set ft=erlang

" CSS:
augroup stylesheets_autocomplete_hyphen
    autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Strace:
autocmd BufRead,BufNewFile *.strace set filetype=strace

" Python:
augroup highlight_self_and_tabs
    au FileType python syn match keyword '\<self\>'
    au FileType python syn match pyTAB '^\t\+' | hi pyTAB ctermbg=darkblue
augroup END

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


" access help using devdocs.io -- TODO: write plugin?
command! -nargs=? DevDocs :call system('xdg-open http://devdocs.io/#q=<args> &')
au FileType python,ruby,javascript,html,php,eruby,coffee
            \ nnoremap <buffer> K
            \ :exec "DevDocs " . fnameescape(expand('<cword>'))<CR>


" Lisp: setup lisp mode
au FileType lisp set lisp
" Ruby: 2 spaces for indenting
au FileType ruby setlocal shiftwidth=2 expandtab

" go to last known line whenever opening new file
au BufReadPost * 
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

" tell vim to use 256 colors, if supported
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
	set t_Co=256
endif

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

" TODO: wrap this properly, avoid overwriting buffer when error
function! JsonFormat() range
    exec 'normal! :' + a:firstline . ',' . a:lastline . '!python -mjson.tool'
endfunction
nnoremap <leader>j :%call JsonFormat()<cr>
vnoremap <leader>j :call JsonFormat()<cr>

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

" use <leader>r to reload vimrc
nnoremap <leader>r :source $MYVIMRC<cr>:redraw!<cr>:nohlsearch<cr>

augroup gen_tags_for_personal_help
    autocmd BufWritePost ~/.vim/doc/*.txt :helptags ~/.vim/doc
augroup END
