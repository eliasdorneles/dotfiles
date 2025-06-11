
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
let g:undotree_WindowLayout = 4

let g:airline_powerline_fonts = 1

" disabled because causing weird chars in output
let g:airline#extensions#tagbar#enabled = 0

" keep syntastic minimally annoying
let g:syntastic_enable_signs=0
let g:syntastic_python_checkers=['flake8']
let g:syntastic_mode_map = {
            \ "mode": "active",
            \ "active_filetypes": ["ruby", "php", "python", "javascript", "c", "cpp"],
            \ "passive_filetypes": ["puppet", "java"] }

let g:flake8_max_line_length=100

" don't fold docstrings:
let g:SimpylFold_fold_docstring = 0

" make Python plugin Jedi more awesome
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#goto_assignments_command = 'gd'
let g:jedi#goto_command = 'gD'
let g:jedi#popup_on_dot = 0
let g:jedi#rename_command = ""
let g:jedi#smart_auto_mappings = 0


" let g:tagbar_ctags_bin='~/bin/ctags'

" ALE (linter)
" Only use flake8 for Python, because pylint is huge and impossible to appease
let g:ale_linters = {
\ 'python': ['flake8'],
\ 'javascript': ['prettier'],
\}
" Stupid Unicode tricks
let g:ale_sign_info = "🚩"
let g:ale_sign_warning = "🚨"
let g:ale_sign_error = "💥"
let g:ale_sign_style_warning = "💈"  " get it?  /style/ issues?  wow tough crowd
let g:ale_sign_style_error = "🚨"

" Airline; use powerline-style glyphs and colors
let g:airline_powerline_fonts = 1
" ALE
let g:airline#extensions#ale#error_symbol = "🚨"

"Prettier (JS linter):
let g:prettier#config#semi = 'false'
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#print_width = 100

" save and load bookmarks automatically
let g:bookmark_manage_per_buffer = 1

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


let g:localvimrc_whitelist = ['/home/elias/code/']

" use custom hunk text objects for GitGutter
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

" TODO: need to make supertab work nicely w/ lsp autocompletion
" let g:SuperTabDefaultCompletionType = "context"

" COPILOT CONFIG:
let g:copilot_filetypes = {
            \ '*': v:false,
            \ 'gitcommit': v:true,
            \ 'python': v:true,
            \ 'javascript': v:true,
            \ 'Dockerfile': v:true,
            \ 'vue': v:true,
            \ 'js': v:true,
            \ 'sh': v:true,
            \ 'html': v:true,
            \ 'json': v:true,
            \ 'make': v:true,
            \ 'vim': v:true,
            \ 'conf': v:true,
            \ 'c': v:true,
            \ 'zig': v:true,
            \ 'cpp': v:true,
            \ 'sql': v:true,
            \ 'yaml': v:true,
            \ }

" add alternative map for copilot, for when TAB doesn't work (e.g. in Markdown files)
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")


" COC.NVIM CONFIG:
" See: https://github.com/neoclide/coc.nvim#example-vim-configuration

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
" inoremap <silent><expr> <TAB>
" inoremap <TAB>
imap <TAB> <Plug>coc#pum#confirm()
"       \ <Plug>coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


" Make <CR> (Enter) to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>co  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Format selected code
xmap <F9>  <Plug>(coc-format-selected)
nmap <F9>  <Plug>(coc-format-selected)

" Format current buffer
" nmap <F9> :call CocActionAsync('format')<CR>:call CocActionAsync('runCommand', 'editor.action.organizeImport')<CR>
nmap <F9> :call CocActionAsync('format')<CR>

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>
" Show commands
nnoremap <silent><nowait> <leader>cl  :<C-u>CocList commands<cr>
" Search workspace symbols
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent><nowait> <leader>p  :<C-u>CocListResume<CR>
