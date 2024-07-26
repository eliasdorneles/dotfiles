set hlsearch
set ignorecase
set smartcase

" disable startup message
set shortmess+=I

" split by default to the right and below
set splitbelow
set splitright

" setup swap files dir per user
silent :!mkdir -p $HOME/.swap-$USER-vim
set dir=$HOME/.swap-$USER-vim

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" starts with mouse in vim mode
set mouse=a

set scrolloff=2
set pastetoggle=<F10>
set modeline
set shiftwidth=4 tabstop=4 expandtab

" when tab-completing, complete the longest and display menu w/ options
set wildmode=longest:full

set nofoldenable
set showcmd

set clipboard=unnamed



" Show invisible characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set list

let g:netrw_banner=0
let g:netrw_browser_split=4 " open in prior windoe
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',.git'

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

" uses Ctrl-Space for emmet expanding
" let g:user_emmet_expandabbr_key = '<C-space>'

let g:airline_powerline_fonts = 1

" disabled because causing weird chars in output
let g:airline#extensions#tagbar#enabled = 0

let g:tagbar_autoclose = 1
" preserve order in source file
let g:tagbar_sort = 0

" CtrlP config:
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_use_caching = 0

" Use ag in CtrlP for listing files.
" Lightning fast and respects .gitignore (caveat: ignores ctrlp_custom_ignore)
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Use ripgrep in CtrlP for even faster listing files
if executable('rg')
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_switch_buffer = 'et'
endif

" keep syntastic minimally annoying
let g:syntastic_enable_signs=0
let g:syntastic_python_checkers=['flake8']
let g:syntastic_mode_map = {
            \ "mode": "active",
            \ "active_filetypes": ["ruby", "php", "python", "javascript", "c", "cpp"],
            \ "passive_filetypes": ["puppet", "java"] }
" let g:syntastic_debug=1

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
    " highlight self and tabs
    au FileType python syn match keyword '\<self\>'
    au FileType python syn match pyTAB '^\t\+' | hi pyTAB ctermbg=darkblue
augroup END

augroup turtle_config
    au BufRead,BufNewFile *.ttl set filetype=turtle
augroup END

augroup terraform_config
    " au FileType terraform setlocal formatprg=terraform\ fmt\ -
    let g:terraform_fmt_on_save=1
augroup END

augroup elm_config
    au FileType elm set shiftwidth=2 tabstop=2
    au FileType elm setlocal formatprg=elm-format\ --stdin
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


" tell snipMate to use the new parser and shutup
let g:snipMate = { 'snippet_version' : 1 }

let g:asyncrun_open = 6


let g:localvimrc_whitelist = ['/home/elias/code/']

" use custom hunk text objects for GitGutter
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md',
                      \ 'custom_wiki2html': 'vimwiki_markdown',
                      \ 'links_space_char': '_',
                      \ 'path_html': '~/Documents/vimwiki/htmlsite/'}]

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

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

"TODO: find an alternate shortcut for this, as CTRL-S saves the file
" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Format selected code
xmap <F9>  <Plug>(coc-format-selected)
nmap <F9>  <Plug>(coc-format-selected)

" Format current buffer
" nmap <F9> :call CocActionAsync('format')<CR>:call CocActionAsync('runCommand', 'editor.action.organizeImport')<CR>
nmap <F9> :call CocActionAsync('format')<CR>

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:OI` command for organize imports of the current buffer
command! -nargs=0 OI   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <leader>cl  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent><nowait> <leader>p  :<C-u>CocListResume<CR>
