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

augroup highlight_annoying_whitespace_at_eol
    au BufNewFile,BufRead * syntax match annoyingwhitespace '\s\+$' |
                \ highlight annoyingwhitespace ctermbg=red
augroup END

augroup grails_config
    au BufNewFile,BufRead *.gsp setlocal ft=jsp
augroup END

augroup erlang_config
    au BufNewFile,BufRead rebar.config setlocal ft=erlang
    au BufNewFile,BufRead *.app.src setlocal ft=erlang
augroup END

augroup yaml_config
    au FileType yaml setlocal shiftwidth=2 tabstop=2
augroup END

" CSS:
augroup stylesheets_autocomplete_hyphen
    autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

augroup bash_config
    autocmd FileType sh map <leader>r :exec '!clear;'.getline('.')<cr>
augroup END

augroup strace_dump_config
    autocmd BufRead,BufNewFile *.strace setlocal filetype=strace
augroup END

augroup python_config
    " highlight self
    au FileType python syn match keyword '\<self\>'
augroup END

augroup odin_config
    " highlight keywords: in and not_in
    au FileType odin syn match Statement ' in '
    au FileType odin syn match Statement ' not_in '
augroup END

augroup turtle_config
    au BufRead,BufNewFile *.ttl set filetype=turtle
augroup END

augroup terraform_config
    " au FileType terraform setlocal formatprg=terraform\ fmt\ -
    let g:terraform_fmt_on_save=1
augroup END

augroup javascript_config
    au FileType javascript set shiftwidth=2 tabstop=2
    au FileType javascriptreact set shiftwidth=2 tabstop=2
augroup END

augroup gen_tags_for_personal_help
    autocmd BufWritePost ~/.vim/doc/*.txt :helptags ~/.vim/doc
augroup END

augroup lisp_config
    au FileType lisp set lisp
augroup END

augroup ruby_config
    au FileType ruby setlocal shiftwidth=2
augroup END

augroup yjsx_config
    autocmd BufRead,BufNewFile *.yjsx setlocal filetype=xml
augroup END

" enable Emoji substitutions for HTML, Markdown and others
au FileType html,markdown,mmd,text,mail,gitcommit
    \ runtime macros/emoji-ab.vim


" Github Copilot: alternative map for when TAB doesn't work (e.g. in Markdown files)
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
