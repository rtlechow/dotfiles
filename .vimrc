set t_Co=256
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()
colorscheme molokai
let mapleader="," " Remap mapleader from \ to , because \ is not in a standard position on all keyboards. The ',' command does exist in Vim (see |,|), but you probably never use it.
let $PAGER='' " Clear variable inside vim. This is to handle the case where you start Vim normally and want to use Vim's 'Man' function.
set history=1000 " Increase history from 20 default to 1000
set hidden " When a buffer is brought to foreground, remember undo history and marks.
set nu " Enable line numbers.
set noerrorbells " Disable error bells.
set foldmethod=syntax " Markers are used to specify folds.
set foldenable
set foldlevel=1
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
set cul
set ls=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set autowrite
set grepprg=ack

" The following is bad on shared systems because other vim sessions could clobber each other.
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " Store backup files in separate directory instead of all over filesystem.
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " Store swap files in separate directory instead of all over file system.

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

" Vertical split then hop to new buffer
noremap <leader>v :vsp^M^W^W<CR>
noremap <leader>h :split^M^W^W<CR>

" Make Y work as expected
noremap Y y$

" Buffer navigation
map <Leader>, <C-^>
map <Leader>] :bnext<CR>
map <Leader>[ :bprev<CR>
map <Leader>ls :buffers<CR>

" Insert newline
map <S-Enter> O<ESC>

" Toggle paste
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>

" Open ~/.vimrc
nnoremap <leader>V :tabnew ~/.vimrc<CR>

" Reload ~/.vimrc and activate changes (have to save first)
nnoremap <silent> <leader>R :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Alternatives for Esc to exit insert mode.
imap lkj <ESC>
imap kjh <ESC>
imap jj <ESC>
imap uu _
imap hh <space>=><space>
imap aa @

" Toggle search highlighting.
nnoremap <silent> <leader>H :set invhls hls?<CR>

" Rerun the last command
nnoremap <leader>. :<Up><CR>

" Toggle show tabs and trailing spaces.
set lcs=tab:>-,trail:·,eol:$,nbsp:_
set fcs=fold:-
nnoremap <silent> <leader>c :set nolist!<CR>

" Ruby
nnoremap <leader>i :!irb<CR>
nnoremap <leader>r :!ruby %<CR>

" Drop to shell.
nnoremap <leader>s :sh<CR>

" Improve autocomplete menu color.
highlight Pmenu ctermbg=238 gui=bold

" Abbreviations.
ab ubpy #!/usr/bin/python
ab ubpl #!/usr/bin/perl
ab bsh #!/bin/sh
ab ubr #!/usr/bin/ruby

" Backspace by words.
map <Bs> bdw.

autocmd BufNewFile,BufRead *_spec.rb compiler rspec
autocmd BufNewFile,BufRead *_test.rb compiler rubyunit

map <leader>gs :Gstatus<cr>
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>
set wildignore+=.git,tmp/**,vendor/bundle/**
