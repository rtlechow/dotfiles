if &term =~# '^screen'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set t_Co=256
set termguicolors
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
colorscheme molokai

set rtp+=/usr/local/opt/fzf
let mapleader="," " Remap mapleader from \ to , because \ is not in a standard position on all keyboards. The ',' command does exist in Vim (see |,|), but you probably never use it.
let $PAGER='' " Clear variable inside vim. This is to handle the case where you start Vim normally and want to use Vim's 'Man' function.
set history=1000 " Increase history from 20 default to 1000
set nohidden
set nonu " Disable line numbers.
set noerrorbells " Disable error bells.

set foldmethod=manual
set nofoldenable
autocmd FileType markdown setlocal foldmethod=syntax

set esckeys " Allow cursor keys in insert mode.
set nohlsearch " Enable search result highlighting.
set incsearch " Highlight dynamically as pattern is typed.
set noinsertmode " Don't start vim in insert mode.
set magic " Enable extended regexes.
set report=0 " Show all changes.
set ruler " Show the cursor position.
set shortmess=I " Don't show the intro message when starting vim.
set showmode " Show the current mode.
set nostartofline " Don't jump to the start of the line when moving around.
set title " Show the filename in the window titlebar.
set wildchar=<TAB> " Character for CLI expansion (TAB-completion).
set wildmenu " Hitting TAB in command mode will show possible completions above command line.
set wildmode=list:longest " Complete only until point of ambiguity.
set expandtab " Expand tabs to spaces.
set tabstop=2 " Hitting the tab key results in 4 spaces.
set shiftwidth=2 " The # of spaces for indenting.
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.
set autoindent " Copy indent from last line when starting new line.
set backspace=start,indent,eol
set ignorecase " In searches, ignore case of lower case letters.
set smartcase " Override ignorecase if search contains upper case letters.
set scrolloff=3 " Start scrolling three lines before horizontal border of window.
set shortmess=atI " Shorten command line text and other info tokens.
set splitbelow splitright
set ls=2
set statusline=%<%f\ %h%m%r(%{FugitiveHead()})%=%-14.(%l,%c%V%)\ %P
set autowrite
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_winsize=75
set grepprg=ack
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
augroup myvimrc
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END
set diffopt=filler,vertical
if has("patch-8.1.0360")
  set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

" The following is bad on shared systems because other vim sessions could clobber each other.
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " Store backup files in separate directory instead of all over filesystem.
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " Store swap files in separate directory instead of all over file system.

nnoremap ; :

" Sudo write
noremap <leader>W :w !sudo tee %<CR>

" Faster split navigation.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Speed up viewport scrolling.
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Set syntax highlighting options.
syntax on

" Set filetype highlighting and configuration.
filetype on
filetype plugin on
filetype indent on

" Make Y work as expected
noremap Y y$

" Buffer navigation
map <Leader>, <C-^>
map <Leader>] :bnext<CR>
map <Leader>[ :bprev<CR>

" Insert newline
map <S-Enter> O<ESC>

" Toggle paste
set pastetoggle=<leader><leader>p
map <leader><leader>p :set invpaste paste?<CR>

map <silent> <leader>y "+y

" Open ~/.vimrc
nnoremap <leader>V :tabnew ~/.vimrc<CR>

" Reload ~/.vimrc and activate changes (have to save first)
nnoremap <silent> <leader>R :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" imaps
imap hh <space>=><space>

" Toggle search highlighting.
nnoremap <silent> <leader>H :set invhls hls?<CR>

" Rerun the last command
nnoremap <leader>. :<Up><CR>

" Toggle show tabs and trailing spaces.
set lcs=tab:>-,trail:·,eol:$,nbsp:_
set fcs=fold:-
nnoremap <silent> <leader>C :set nolist!<CR>

" Ruby
nnoremap <leader>i :!irb<CR>
nnoremap <leader>r :!"%"<CR>

" Improve autocomplete menu color.
highlight Pmenu ctermbg=238 gui=bold

" Abbreviations.
ab ubpy #!/usr/bin/python
ab ubpl #!/usr/bin/perl
ab bsh #!/bin/sh
ab ubr #!/usr/bin/ruby

" Backspace by words.
map <Bs> bdw.

" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

autocmd FileType gitcommit setlocal spell
autocmd BufReadPost fugitive://* set bufhidden=delete
nnoremap <leader>gs :0Git<cr>:normal gU<cr>
map <leader>gb :Git blame<cr>
command -nargs=? -bar Gshow call setqflist(map(systemlist("git show --pretty='' --name-only <args>"), '{"filename": v:val, "lnum": 1}'))

let g:vimrubocop_rubocop_cmd = "git diff --name-only HEAD | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs rubocop "

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
"let test#vim#term_position = '20belowright'
let test#strategy = {
  \ 'nearest': 'vimterminal',
  \ 'file':    'vimterminal',
  \ 'suite':   'basic'
\}
let g:dispatch_quickfix_height = 20

let g:jsx_ext_required = 0
let g:table_mode_corner = '|'
let g:dbext_default_history_file = '~/.dbext_history'
let g:rails_erb_yaml = 1
set confirm " vim-rails :AV create a spec if missing

" CTRL-A CTRL-Q to select all and build quickfix list
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
nmap <Leader>f :Files<CR>
nmap <Leader>ag :Ag<CR>
nmap <Leader>rg :Rg<CR>
nmap <Leader><Leader>l :Lines<CR>
nmap <Leader><Leader>t :Tags<CR>
nmap <Leader><Leader>bt :BTags<CR>
nmap <Leader><Leader>co :Commits<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :Helptags<CR>
let $FZF_DEFAULT_OPTS = '--layout=reverse --bind ctrl-a:select-all'
let $FZF_DEFAULT_COMMAND='fd --type f'
let g:fzf_buffers_jump = 1

xnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'
xmap <leader>db  <Plug>(DBExe)
nmap <leader>db  <Plug>(DBExe)
omap <leader>db  <Plug>(DBExe)
nmap <leader>dbb <Plug>(DBExeLine)

let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Google Chrome'

au BufEnter /private/tmp/crontab.* setl backupcopy=yes
silent! helptags ALL
set tags^=./.git/tags;

let g:ale_linters = {
\  'ruby': ['rubocop'],
\}
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'ruby': ['rubocop'],
\}
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_insert_leave=0
let g:ale_lint_on_enter=0
let g:ale_pattern_options = {
\   '.*/\.rbenv/.*$': {'ale_enabled': 0},
\}

let g:Hexokinase_highlighters = ['backgroundfull']

source ~/.local/local.vim
