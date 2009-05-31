set t_Co=256
colorscheme railscasts
let mapleader="," " Remap mapleader from \ to , because \ is not in a standard position on all keyboards. The ',' command does exist in Vim (see |,|), but you probably never use it.
set history=1000 " Increase history from 20 default to 1000
set hidden " When a buffer is brought to foreground, remember undo history and marks.
set nu " Enable line numbers.
set noerrorbells " Disable error bells.
set foldmethod=syntax " Markers are used to specify folds.
set esckeys " Allow cursor keys in insert mode.
set hlsearch " Enable search result highlighting.
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

" The following is bad on shared systems because other vim sessions could clobber each other.
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " Store backup files in separate directory instead of all over filesystem.
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " Store swap files in separate directory instead of all over file system.

" Speed up viewport scrolling.
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Set syntax highlighting options.
syntax on

" Set filetype highlighting and configuration.
filetype on
filetype plugin on
filetype indent on

"  to toggle paste
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>

" ,t to toggle NERDTree
map <leader>t :NERDTreeToggle<CR>

" ,V to open ~/.vimrc
map <leader>V :tabnew ~/.vimrc<CR><C-W>_

" ,v to reload ~/.vimrc and activate changes (have to save first)
map <silent> <leader>v :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Alternatives for Esc to exit insert mode.
imap lkj <esc>
imap kjh <esc>

" Toggle search highlighting. 
nmap <silent> <leader>n :silent :set nohls!<CR>:silent :set nohls?<CR>

" Toggle show tabs and trailing spaces.
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Enable switching between if/elsif/else/end.
runtime macros/matchit.vim

" Ruby.
autocmd BufNewFile,BufRead *.rb source ~/.vim/scripts/rubysnippets.vim 
autocmd Filetype ruby source ~/.Vim/ruby-macros.vim
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
au BufNewFile,BufRead capfile setf ruby 
nmap <leader>i :!irb<CR>

" Drop to shell.
nmap <leader>s :sh<CR>

" Improve autocomplete menu color.
highlight Pmenu ctermbg=238 gui=bold

" Abbreviations.
ab ubpy #!/usr/bin/python
ab ubpl #!/usr/bin/perl
ab bsh #!/bin/sh
ab ubr #!/usr/bin/ruby

" Backspace by words.
map <Bs> bdw.

function ToSomaBuffer(text)
  let name = substitute(system("whoami"), "\n", "", "")
  call writefile(split(a:text, '\n'), "/tmp/". name . "_somarepl_buffer")
endfunction
  
vmap <C-c><C-c> "ry :call ToSomaBuffer(@r)<CR>
nmap <C-c><C-c> vip<C-c><C-c>
