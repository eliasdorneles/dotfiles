set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
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

" this has not been much useful -- requires too much cognition
Bundle "Lokaltog/vim-easymotion"

" Ctrl-P, Ctrl-P, Ctrl-P, Ctrl-P!
Bundle "kien/ctrlp.vim"

Bundle "tpope/vim-capslock"
Bundle "scrooloose/syntastic"
Bundle "othree/html5.vim"
Bundle "jnwhiteh/vim-golang"

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
Bundle "jpalardy/vim-slime"

Bundle "majutsushi/tagbar"

" :Rename to rename file in current buffer
Bundle "danro/rename.vim"

" :Scratch to open scratch window
Bundle "mtth/scratch.vim"

" exchange with cx (motion or selection)
Bundle "tommcdo/vim-exchange"

Bundle "sjl/clam.vim"


filetype plugin indent on
syntax on
set hlsearch

" setup swap file dir
silent :!mkdir -p /tmp/.vim-swap
set dir=/tmp/.vim-swap

" disables mouse
set mouse=

set scrolloff=2
set pastetoggle=<F10>
set modeline
set sw=4 ts=4 expandtab

" is this the leader mapping I was waiting for?
let mapleader = "-"

" maps %% to expand path of current file directory in cmd mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" visually select the text that was last edited/pasted
nmap gV `[v`]

" keep my sanity whenever I type :Wq or :W
cab W w|cab Q q|cab Wq wq|cab wQ wq|cab WQ wq

if has("gui_running")
    set guifont=Monospace\ 12
    set guioptions=aegiclA
    set lines=40 columns=80
endif

" highlight annoying whitespace at end of line
syn match annoyingwhite '\s\+$' | hi annoyingwhite ctermbg=red

" Groovy and Grails:
au BufNewFile,BufRead *.gsp set ft=jsp

" Python: highlight self, None and <TAB>s
au FileType python syn match keyword '\<self\>'
au FileType python syn match pyTAB '^\t\+' | hi pyTAB ctermbg=darkblue
let g:flake8_max_line_length=100
function! ShowPydoc(what)
    let bufname = a:what . ".pydoc"
    " check if the buffer exists already
    if bufexists(bufname)
        let winnr = bufwinnr(bufname)
        if winnr != -1
            " if the buffer is already displayed, switch to that window
            execute winnr "wincmd w"
        else
            " otherwise, open the buffer in a split
            execute "sbuffer" bufname
        endif
    else
        " create a new buffer, set the nofile buftype and don't display it in the
        " buffer list
        execute "split" fnameescape(bufname)
        setlocal buftype=nofile
        setlocal nobuflisted
        " read the output from pydoc
        execute "r !" . shellescape(s:pydoc_path, 1) . " " . shellescape(a:what, 1)
    endif
    " go to the first line of the document
    1
endfunction

" Lisp: setup lisp mode
au FileType lisp set lisp
" Ruby: 2 spaces for indenting
au FileType ruby setlocal shiftwidth=2 expandtab

" customize emmet
let g:user_emmet_expandabbr_key = '<c-e>'

" go to last known line whenever opening new file
au BufReadPost * 
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

" don't let golden-ratio resize nonmodifiable buffers
let g:golden_ratio_exclude_nonmodifiable = 1

" CtrlP plugin mappings
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" nerdtree toggle with \e
nmap <Leader>e :NERDTreeToggle<CR>

" keep syntastic minimally annoying
let g:syntastic_enable_signs=0
let g:syntastic_python_checkers=['flake8', 'pylint']

" tell vim to use 256 colors, if supported
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
	set t_Co=256
endif

" save using <C-S>
command -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
nnoremap <silent> <C-S> :<C-u>Update<CR>
inoremap <silent> <C-S> <Esc>:<C-u>Update<CR>a

" open tagbar for these filetypes
autocmd FileType python,java,erlang,c,cpp nested :TagbarOpen

"windows:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" quick no-regex search
map <C-f> /\V

" disable highlight search when pressing ENTER on normal mode
nnoremap <CR> :nohlsearch<CR><CR>

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": ":.1"}

command -nargs=0 Jsonfmt :%!python -mjson.tool

" clipboard mappings:
vmap <leader>y "+y
map <leader>p "+p

" opens a new tab with the current buffer's path
"map <leader>tn :exe "tabnew" expand("%:p:h")<cr>
