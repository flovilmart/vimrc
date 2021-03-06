let g:airline_theme='solarized'
let g:airline#extensions#ale#enabled = 1

""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd']

nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste

""""""""""""""""""""""""""""""
" => FZF
""""""""""""""""""""""""""""""
" FZF key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-v': 'vsplit' }
set rtp+=/usr/local/opt/fzf
nmap ; :Buffers<CR>
nmap <Leader>o :Files<CR>

nmap <Leader>r :Ag <C-R><C-W> *<CR>
nmap <Leader>f :Ag<CR>

""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'


""""""""""""""""""""""""""""""
" => snipMate (beside <TAB> support <CTRL-j>)
""""""""""""""""""""""""""""""
ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd vimenter * NERDTree

" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerdtree-tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:nerdtree_tabs_open_on_console_startup=1
map <leader>nf :NERDTreeTabsFind<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-s>'
let g:multi_cursor_select_all_word_key = '<A-s>'
let g:multi_cursor_start_key           = 'g<C-s>'
let g:multi_cursor_select_all_key      = 'g<A-s>'
let g:multi_cursor_next_key            = '<C-s>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimroom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command = "goimports"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" => Syntastic (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'python': ['flake8'],
\   'ruby': ['rubocop'],
\   'go': ['go', 'golint', 'errcheck']
\}

let b:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['prettier', 'eslint'],
\  'ruby': ['rubocop']
\}

nmap <silent> <leader>a <Plug>(ale_next_wrap)

" Disabling highlighting
let g:ale_set_highlights = 1
let g:ale_sign_column_always = 1
let g:ale_open_list = 0

" Compat with coc.vim
let g:ale_disable_lsp = 1
" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_tsserver_use_global = 1
map <C-]> :ALEGoToDefinition<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=1
set updatetime=100

nnoremap <silent> <leader>d :GitGutterToggle<cr>

let g:gitgutter_override_sign_column_highlight = 0


" vim-test
"
function! TransformExecRubyApp(cmd) abort
  return 'docker-compose exec -e RAILS_ENV=test app sh -c '.shellescape(a:cmd)
endfunction
function! TransformRubyApp(cmd) abort
  return 'docker-compose run --rm -e RAILS_ENV=test --entrypoint='.shellescape(a:cmd). ' app'
endfunction
function! DockerComposeExec(cmd, app) abort
    return 'docker-compose exec '.a:app.' sh -c '.shellescape(a:cmd)
endfunction

function! TransformDockerCompose(cmd) abort
  if getcwd() =~ "hodor"
    return DockerComposeExec(a:cmd, "hodor")
  endif
  if getcwd() =~ "flatbook"
    return DockerComposeExec(a:cmd, "flatbook")
  endif
  return TransformRubyApp(a:cmd)
endfunction

let g:test#custom_transformations = {'do': function('TransformDockerCompose')}
let g:test#transformation = 'do'
let test#strategy = "vimux"

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
