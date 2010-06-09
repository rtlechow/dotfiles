set t_Co=256
colorscheme railscasts
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

" The following is bad on shared systems because other vim sessions could clobber each other.
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " Store backup files in separate directory instead of all over filesystem.
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " Store swap files in separate directory instead of all over file system.

" Sudo write
noremap <leader>W :w !sudo tee %<CR>

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

" Toggle NERDTree
let NERDTreeShowLineNumbers=1
nnoremap <leader>n :NERDTreeToggle<CR>

" Open ~/.vimrc
nnoremap <leader>V :tabnew ~/.vimrc<CR>

" Reload ~/.vimrc and activate changes (have to save first)
nnoremap <silent> <leader>R :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" FuzzyFinder
nnoremap <leader>ff :FuzzyFinderFileWithCurrentBufferDir<CR>
nnoremap <leader>fb :FuzzyFinderBuffer<CR>

" Alternatives for Esc to exit insert mode.
imap lkj <ESC>
imap kjh <ESC>
imap jj <ESC>
imap uu _
imap hh =>
imap aa @

" Toggle search highlighting. 
nnoremap <silent> <leader>H :set invhls hls?<CR>

" Rerun the last command
nnoremap <leader>. :<Up><CR>

" Toggle show tabs and trailing spaces.
set lcs=tab:>-,trail:·,eol:$,nbsp:_
set fcs=fold:-
nnoremap <silent> <leader>c :set nolist!<CR>

" Enable switching between if/elsif/else/end.
runtime macros/matchit.vim

" Ruby
au BufNewFile,BufRead capfile setf ruby 
nnoremap <leader>i :!irb<CR>
nnoremap <leader>r :!ruby %<CR>

" Objective-J
augroup objective-j
au! BufRead,BufNewFile *.j set filetype=objective-j
au! Syntax objective-j source ~/.vim/syntax/objj.vim
augroup END

" Markdown
augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
augroup END

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

" http://vim.wikia.com/wiki/Change_to_the_directory_of_the_current_file
if exists('+autochdir')
  set autochdir
else
  autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

" http://ja.pastebin.ca/raw/1243579
" }}}
" MyTabLine {{{
" This is an attempt to emulate the default Vim-7 tabs as closely as possible but with numbered tabs.
" TODO: set truncation when tabs don't fit on line, see :h columns
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        for i in range(tabpagenr('$'))
            " set up some oft-used variables
            let tab = i + 1 " range() starts at 0
            let winnr = tabpagewinnr(tab) " gets current window of current tab
            let buflist = tabpagebuflist(tab) " list of buffers associated with the windows in the current tab
            let bufnr = buflist[winnr - 1] " current buffer number
            let bufname = bufname(bufnr) " gets the name of the current buffer in the current window of the current tab

            let s .= '%' . tab . 'T' " start a tab
            let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#') " if this tab is the current tab...set the right highlighting
            let s .= ' #' . tab " current tab number
            let n = tabpagewinnr(tab,'$') " get the number of windows in the current tab
            if n > 1
                let s .= ':' . n " if there's more than one, add a colon and display the count
            endif
      let bufmodified = getbufvar(bufnr, "&mod")
            if bufmodified
                let s .= ' +'
            endif
            if bufname != ''
                let s .= ' ' . pathshorten(bufname) . ' ' " outputs the one-letter-path shorthand & filename
            else
                let s .= ' [No Name] '
            endif
        endfor
        let s .= '%#TabLineFill#' " blank highlighting between the tabs and the righthand close 'X'
        let s .= '%T' " resets tab page number?
        let s .= '%=' " seperate left-aligned from right-aligned
        let s .= '%#TabLine#' " set highlight for the 'X' below
        let s .= '%999XX' " places an 'X' at the far-right
        return s
    endfunction
    set tabline=%!MyTabLine()
endif

function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
noremap <leader>t :call StripWhitespace ()<CR>

let g:fuf_modesDisable = []
let g:fuf_abbrevMap = {
      \   '^vr:' : map(filter(split(&runtimepath, ','), 'v:val !~ "after$"'), 'v:val . ''/**/'''),
      \   '^m0:' : [ '/mnt/d/0/', '/mnt/j/0/' ],
      \ }
let g:fuf_mrufile_maxItem = 300
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> <C-n>      :FufBuffer<CR>
nnoremap <silent> <C-p>      :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> <C-f><C-p> :FufFileWithFullCwd<CR>
nnoremap <silent> <C-f>p     :FufFile<CR>
nnoremap <silent> <C-f><C-d> :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> <C-f>d     :FufDirWithFullCwd<CR>
nnoremap <silent> <C-f>D     :FufDir<CR>
nnoremap <silent> <C-j>      :FufMruFile<CR>
nnoremap <silent> <C-k>      :FufMruCmd<CR>
nnoremap <silent> <C-b>      :FufBookmark<CR>
nnoremap <silent> <C-f><C-t> :FufTag<CR>
nnoremap <silent> <C-f>t     :FufTag!<CR>
noremap  <silent> g]         :FufTagWithCursorWord!<CR>
nnoremap <silent> <C-f><C-f> :FufTaggedFile<CR>
nnoremap <silent> <C-f><C-j> :FufJumpList<CR>
nnoremap <silent> <C-f><C-g> :FufChangeList<CR>
nnoremap <silent> <C-f><C-q> :FufQuickfix<CR>
nnoremap <silent> <C-f><C-l> :FufLine<CR>
nnoremap <silent> <C-f><C-h> :FufHelp<CR>
nnoremap <silent> <C-f><C-b> :FufAddBookmark<CR>
vnoremap <silent> <C-f><C-b> :FufAddBookmarkAsSelectedText<CR>
nnoremap <silent> <C-f><C-e> :FufEditInfo<CR>
nnoremap <silent> <C-f><C-r> :FufRenewCache<CR>
