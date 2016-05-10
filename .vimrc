set nocompatible

" Loading plugins
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-scripts/taglist.vim', { 'on': 'Tlist' }
Plug 'Shougo/vimproc.vim' | Plug 'Shougo/vimshell.vim', {'on': 'VimShell' }
call plug#end()

" Basics {
    set nocompatible " explicitly get out of vi-compatible mode
    set noexrc " don't use local version of .(g)vimrc, .exrc
    colorscheme elflord
    set background=dark " we plan to use a dark background
    set cpoptions=aABceFsmq
    "             |||||||||
    "             ||||||||+-- When joining lines, leave the cursor
    "             |||||||      between joined lines
    "             |||||||+-- When a new match is created (showmatch)
    "             ||||||      pause for .5
    "             ||||||+-- Set buffer options when entering the
    "             |||||      buffer
    "             |||||+-- :write command updates current file name
    "             ||||+-- Automatically add <CR> to the last line
    "             |||      when using :@r
    "             |||+-- Searching continues at the end of the match
    "             ||      at the cursor position
    "             ||+-- A backslash has no special meaning in mappings
    "             |+-- :write updates alternative file name
    "             +-- :read updates alternative file name
    syntax on " syntax highlighting on
" }


" General {
    filetype plugin indent on " load filetype plugins/indent settings
    "set autochdir " always switch to the current file directory
    set backspace=indent,eol,start " make backspace a more flexible
    set nobackup " do not make backup files
    set clipboard=unnamedplus " share windows clipboard
    set fileformats=unix,dos,mac " support all three, in this order
    set hidden " you can change buffers without saving
    " (XXX: #VIM/tpope warns the line below could break things)
    set iskeyword+=_,$,@,%,# " none of these are word dividers
    set mouse=a " use mouse everywhere
    set noerrorbells " don't make noise
    set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
    "             | | | | | | | | |
    "             | | | | | | | | +-- "]" Insert and Replace
    "             | | | | | | | +-- "[" Insert and Replace
    "             | | | | | | +-- "~" Normal
    "             | | | | | +-- <Right> Normal and Visual
    "             | | | | +-- <Left> Normal and Visual
    "             | | | +-- "l" Normal and Visual (not recommended)
    "             | | +-- "h" Normal and Visual (not recommended)
    "             | +-- <Space> Normal and Visual
    "             +-- <BS> Normal and Visual
    set wildmenu " turn on command line completion wild style
    " ignore these list file extensions
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,
                    \*.jpg,*.gif,*.png
    set wildmode=list:longest " turn on wild mode huge list
    set tags=tags;/
" }

" Vim UI {
    "set cursorcolumn " highlight the current column
    set cursorline " highlight current line
    set incsearch " BUT do highlight as you type you
                   " search phrase
    set laststatus=2 " always show the status line
    set lazyredraw " do not redraw while running macros
    set linespace=0 " don't insert any extra pixel lines
                     " betweens rows
    set list " we do what to show tabs, to ensure we get them
              " out of my files
    set listchars=tab:>-,trail:-,extends:>,precedes:<" show tabs and trailing
    set matchtime=5 " how many tenths of a second to blink
                     " matching brackets for
    set nohlsearch " do not highlight searched for phrases
    set nostartofline " leave my cursor where it was
    set novisualbell " don't blink
    set number " turn on line numbers
    set numberwidth=5 " We are good up to 99999 lines
    set report=0 " tell us when anything is changed via :...
    set ruler " Always show current positions along the bottom
    set scrolloff=10 " Keep 10 lines (top/bottom) for scope
    set shortmess=aOstT " shortens messages to avoid
                         " 'press a key' prompt
    set showcmd " show the command being typed
    set showmatch " show matching brackets
    set sidescrolloff=10 " Keep 5 lines at the size
    set statusline=%<%t\ %h%m%r%w[%L][%{&ff}]%y[PWD:%{getcwd()}]%=%-14.(%l,%c%V%)\ [\ %P\ ]
" }

" Text Formatting/Layout {
    set completeopt= " don't use a pop up menu for completions

    set expandtab " no real tabs please!
    set formatoptions=rq " Automatically insert comment leader on return,
                          " and let gq format comments
    set ignorecase " case insensitive by default
    set infercase " case inferred by default
    set nowrap " do not wrap line
    set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
    set smartcase " if there are caps, go case-sensitive
    set shiftwidth=4 " auto-indent amount when using cindent,
                      " >>, << and stuff like that
    set softtabstop=4 " when hitting tab or backspace, how many spaces
                       "should a tab be (see expandtab)
    set tabstop=8 " real tabs should be 8, and they will show with
                   " set list on
" }

" Folding {
    set foldenable " Turn on folding
    set foldmarker={,} " Fold C style code (only use this as default
                        " if you use a high foldlevel)
    set foldmethod=marker " Fold on the marker
    set foldlevel=100 " Don't autofold anything (but I can still
                      " fold manually)
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements
                                                      " open folds
    function SimpleFoldText() " {
        return getline(v:foldstart).' '
    endfunction " }
    set foldtext=SimpleFoldText() " Custom fold text function
                                   " (cleaner than default)
" }

" Mappings {
    " ROT13 - fun
    map <F12> ggVGg?

    " space / shift-space scroll in normal mode
    noremap <S-space> <C-b>
    noremap <space> <C-f>

    " ctrl-a select all
    map <C-a> ggVG

    " ctrl-enter create newline above
    imap <C-CR> <ESC>O

    " Make Arrow Keys Useful Again {
        map <down> <ESC>:bn<RETURN>
        map <left> <ESC>:NERDTreeToggle<RETURN>
        map <right> <ESC>:Tlist<RETURN>
        map <up> <ESC>:bp<RETURN>
    " }

    " Ctags shortcut
    map <C-F12> :!ctags -R --c++-kinds=+px-d --c-kinds=+px-d --fields=+iaS --extra=+q <CR>
" }

" GUI Settings {
if has("gui_running")
    " Basics {
        colorscheme solarized " only works in GUI
        set background=light
        set columns=100 " perfect size for me
        set guifont=Sauce\ Code\ Powerline\ 10
        set guioptions=ce
        "              ||
        "              |+-- use simple dialogs rather than pop-ups
        "              +  use GUI tabs, not console style tabs
        set lines=40 " perfect size for me
        set mousehide " hide the mouse cursor when typing
    " }

    " Popup menu colors
    highlight Pmenu    guibg=darkgrey  guifg=black
    highlight PmenuSel guibg=lightgrey guifg=black

    " Font Switching Binds {
        "map <F9> <ESC>:set guifont=Consolas:h10<CR>
        "map <F10> <ESC>:set guifont=Consolas:h12<CR>
        "map <F11> <ESC>:set guifont=Consolas:h16<CR>
    " }
endif
" }

" FileType Specific Settings {
au FileType go set nolist
" }

" Taglist {
let g:Tlist_Use_Right_Window = 1
let g:Tlist_Ctags_Cmd = '/usr/bin/ctags'
" }

" Airline {
if has("gui_running")
let g:airline_powerline_fonts = 1
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" }

" CtrlP {
let g:ctrlp_working_path_mode = ''
" }

" The Silver Searcher {
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Usa ag in CtrlP for listing files. Lightning fast and respects
    " .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" }
