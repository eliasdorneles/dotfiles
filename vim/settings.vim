" Show invisible characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set list

" Keep undo history across sessions, by storing it in a file.
set undolevels=1000
if has('persistent_undo')
  if has('nvim')
    silent !mkdir -p ~/.local/share/nvim/undo > /dev/null 2>&1
    set undodir=~/.local/share/nvim/undo
  else
    silent !mkdir -p ~/.local/share/vim/undo > /dev/null 2>&1
    set undodir=~/.local/share/vim/undo
  end
  set undofile
endif

if has("gui_running")
    set guifont=Monospace\ 12
    set guioptions=aegiclA
    set lines=40 columns=140
    colorscheme molokai
else
    try
        " colorscheme tender
        colorscheme gruvbox
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
        set background=dark
    endtry
endif

" use 256 colors, if supported
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
	set t_Co=256
endif

augroup go_to_last_known_line_when_open_file
    au BufReadPost * 
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
augroup END


" enable Emoji substitutions for HTML, Markdown and others
au FileType html,markdown,mmd,text,mail,gitcommit
    \ runtime macros/emoji-ab.vim


" Github Copilot: alternative map for when TAB doesn't work (e.g. in Markdown files)
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
