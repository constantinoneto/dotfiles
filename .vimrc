" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Necessary on some Linux distros for pathogen to properly load bundles
filetype off

call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

" Enable detection, plugins and indenting in one step
filetype plugin indent on

" Editing behaviour {{{
set showmode                    " always show what mode we're currently editing in
set showbreak=...               " show break
set wrap linebreak              " wrap lines
set tabstop=2                   " a tab is two spaces
set softtabstop=2               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=2                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set sidescrolloff=7
set sidescroll=1
"set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set listchars=tab:>-,trail:.,precedes:<,extends:>

set nolist                      " don't show invisible characters by default,
                                " but it is enabled for some file types (see later)
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid)
set formatoptions-=o            " dont continue comments when pushing o/O

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" }}}

" Folding rules {{{
set foldmethod=indent           " fold based on indent
set foldnestmax=3               " deepest fold is 3 levels
set nofoldenable                " dont fold by default
set foldlevel=1                 " this is just what i use
set foldcolumn=0                " add a fold column
set foldlevelstart=0            " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
" }}}

" Editor layout {{{
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set cmdheight=1                 " use a status bar that is 1 row high
set linespace=4                 " add some line space for easy reading
" }}}

" Vim behaviour {{{
set hidden                      " hide buffers instead of closing them this
                                "    means that the current buffer can be put
                                "    to background without being written; and
                                "    that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
if v:version >= 730
  set undofile                  " keep a persistent backup file
  set undodir=~/.vim/.undo,~/tmp,/tmp
endif
set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
                                "    who did ever restore from swap files anyway?
set directory=~/.vim/.tmp,~/tmp,/tmp
                                " store swap files in one of these directories
                                "    (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "    than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                "    first full match
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj,*~
set title                       " change the terminal's title
set novisualbell                " don't beep
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen
                                "    this also shows visual selection info
set nomodeline                  " disable mode lines (security measure)
"set ttyfast                     " always use a fast terminal
"set cursorline                  " underline the current line, for quick orientation

" Tame the quickfix window (open/close using F10)
nmap <silent> <F10> :QFix<CR>

command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

" Restore cursor position
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

" }}}

" Highlighting {{{

if &t_Co > 2 || has("gui_running")
  syntax on                    " switch syntax highlighting on, when the terminal has colors
  set background=dark
endif

if &t_Co >= 256 || has("gui_running")
  colorscheme solarized
endif

" }}}

" Shortcut mappings {{{
" Since I never use the ; key anyway, this is a real optimization for almost
" all Vim commands, since we don't have to press that annoying Shift key that
" slows the commands down
nnoremap ; :

" Avoid accidental hits of <F1> while aiming for <Esc>
map! <F1> <Esc>

" Use Q for formatting the current paragraph (or visual selection)
vmap Q gq
nmap Q gqap

" Make possible to navigate within lines of wrapped lines
nnoremap j gj
nnoremap k gk
nmap <Down> gj
nmap <Up> gk
set fo=l

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <leader>w <C-w>v<C-w>l

" Open file under cursor
map <leader>o :vertical wincmd f<CR>

" Complete whole filenames/lines with a quicker shortcut key in insert mode
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" Quick yanking to the end of the line
nmap Y y$

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Clears the search register
nmap <silent> <leader>/ :nohlsearch<CR>

" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
inoremap jj <Esc>
inoremap jk <Esc>

" Quick alignment of text
nmap <leader>al :left<CR>
nmap <leader>ar :right<CR>
nmap <leader>ac :center<CR>

" Pull word under cursor into LHS of a substitute (for quick search and
" replace)
nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %

" Folding
nnoremap <Space> za
vnoremap <Space> za

" Strip all trailing whitespace from a file, using ,w
nnoremap <leader>$ :%s/\s\+$//<cr>:let @/=''<CR>

" Run Ack fast (mind the trailing space here, wouldya?)
nnoremap <leader>a :Ack

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Quickly close the current window
nnoremap <leader>q :q<CR>

" tabedit shortcuts like firefox
map <leader>0 :tablast<CR>
map <leader>1 1gt
map <leader>2 2gt
map <leader>3 3gt
map <leader>4 4gt
map <leader>5 5gt
map <leader>6 6gt
map <leader>7 7gt
map <leader>8 8gt
map <leader>9 9gt
map <C-o> :tabonly<CR>
map <C-Right> <ESC>:tabnext<CR>
map <C-Left> <ESC>:tabprev<CR>
map <C-t> <ESC>:tabnew<CR>

" }}}

" Status Line {{{
set statusline=%f               " tail of the filename


" document details
set statusline+=%=              " left/right separator
set statusline+=%c,             " cursor column
set statusline+=%l/%L           " cursor line/total lines
set statusline+=\ %P            " percent through file

set laststatus=2                " tell VIM to always put a status line in, even
                                "    if there is only one window

" }}}

" Plugins Settings {{{

" syntastic
let g:syntastic_enable_signs=1

" ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Command-T
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1

" bufexplorer
nnoremap <F6> :BufExplorer<CR>

" spell check
map <leader>s :set spell<CR>
" set spelllang=en_us

" taglist
let Tlist_GainFocus_On_ToggleOpen = 1
nnoremap <F7> :TlistToggle<CR>

" scratch
"noremap <F8> :Scratch<CR>

" NerdTree
nnoremap <F9> :NERDTreeToggle<CR>

" NerdTree commenter
map <leader>' <leader>c<space><CR>

" CommandT
nnoremap <leader>t :CommandT<CR>

" ragtag
let g:ragtag_global_maps = 1

" indent-guides
let g:indent_guides_guide_size = 2
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

nnoremap <c-b> :CtrlPBuffer<CR>

" snippets
let g:snips_author = "Jonhnny Weslley"

" }}}

" Whitespaces {{{

" highlight EOL whitespace with a red background except on the line you're editing
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" whitespace stripper
function! <SID>StripTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap <silent> <Leader><space> :call <SID>StripTrailingWhitespace()<CR>

" }}}

au BufNewFile,BufRead {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} setf ruby
au BufNewFile,BufRead .dir_colors,.dircolors,/etc/DIR_COLORS setf dircolors
