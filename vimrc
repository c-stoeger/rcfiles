" Christians .vimrc

" just fetch the defaults.vim
" new since vim 8
" unlet! skip_defaults_vim
" source $VIMRUNTIME/defaults.vim

" no compatibility to old vi
set nocompatible

" the local leader key for commands
let maplocalleader=','
let mapleader=','
" 4 spaces tabstop
set tabstop=4
set shiftwidth=4
set autoindent
" indents after e.g. curly braces
set smartindent
" uses spaces instead of tab
set expandtab
" backspacing over autoindent and linebreaks
set backspace=indent,eol,start

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" search down into subfolders right from the pwd
set path+=**

" enable syntax highlighting
syntax on

" we're working on a dark background
" setting this results in better readability of
" syntax highlighted text
set background=dark

" displays matching files during tab completion
set wildmenu
" list all matches and complete to the longest match
set wildmode=full

" display hexcode under cursor
set rulerformat=0x%02B\ %3p%%\ %l,%c%V
" always show the ruler
set ruler

set history=200		" keep 200 lines of command line history

" use the mouse in terminals
set mouse=a

autocmd BufReadPost *
            \ if line("'\"") >= 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
    " Prevent that the langmap option applies to characters that result from a
    " mapping.  If set (default), this may break plugins (but it's backward
    " compatible).
    set nolangremap
endif

" use folding
set foldenable
"set foldmethod=marker
autocmd FileType c,cpp set foldmethod=syntax
autocmd FileType python set foldmethod=indent
" show a column on the side to indicate open and closed folds
set foldcolumn=1
" folds with a higher level are automatically closed
set foldlevel=99

" searching
" highlight the search
set hls
" higlight while searching
set incsearch
" do care about the case during searching
"set ignorecase
" if the user types uppercase - do an exact search
"set smartcase
" switch off the highlighting of search results
nmap <silent> <LocalLeader>n :nohlsearch<CR>

" set the title of the window to the value of titlestring
set title

" show commands in normal and visual mode
set showcmd

" use <C-c> like escape
noremap <C-c> <ESC>

" use <C-z> (suspend vim) even in input mode
imap <C-z> <ESC><C-z>a

" copy to system clipboard
noremap <silent> <LocalLeader>c "+y
" cut to system clipboard
noremap <silent> <LocalLeader>x "+d
" paste from system clipboard
noremap <silent> <LocalLeader>p "+p

" write file
noremap <LocalLeader>w :update<CR>


" do not go to the start of the line when hitting G, etc.
set nosol

" just accept :Q or :Qa ;)
command -bang Q q<bang>
command -bang Qa qa<bang>


" Coding issues
let c_comment_strings=1
" use <F5> for make
noremap <F5> :make<CR>
inoremap <F5> <ESC>:make<CR>

" show linenumbers with <F9>
noremap <silent> <F9> :set number!<CR>
inoremap <silent> <F9> <ESC>:set number!<CR>`]a

" show relative linenumbers with <F10>
" start with relative number on
set relativenumber
noremap <silent> <F10> :set relativenumber!<CR>
inoremap <silent> <F10> <ESC>:set relativenumber!<CR>`]a

" do automatically insertion of closing brackets
inoremap " ""<left>
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
inoremap ' ''<left>
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
inoremap ( ()<left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap [ []<left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap { {}<left>
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" open new split at the right
set splitright
" or bottom
set splitbelow

" persistent undo
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

" Managing plugins {{{
" vundle installation
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'will133/vim-dirdiff'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'lifepillar/vim-solarized8'

call vundle#end()
filetype plugin indent on

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='badwolf'
let g:airline_powerline_fonts=1

let g:bufferline_echo = 0

"packadd minpac
"call minpac#init()
"call minpac#add('will133/vim-dirdiff')
"call minpac#add('tpope/vim-surround')
"call minpac#add('tpope/vim-repeat')

"command! PackUpdate call minpac#update()
"command! PackClean call minpac#clean()
" }}}

let g:DirDiffEnableMappings=1

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
    set guioptions-=t
endif

if has('gui_running')
    " load the solarized colorscheme
    colorscheme solarized8
endif

" source host specific file
if filereadable(".vimrc.host")
    source .vimrc.host
endif

" enable project specific settings
set exrc
" disable unsafe commands in the project specific files.
set secure
