" ----- GENERAL SETTINGS -----"

syntax on
filetype plugin indent on

set hlsearch " Seatch highlighting
set incsearch " When searching, will incrementally search

set ignorecase " Case insensative
set smartcase

set number " Shows line numbers
set ruler " Shows ruler
set showcmd "Shows currently entering command
set nocompatible "Set nocompatible mode to stop pretending like it's vi"
set wildmenu "Shows smart autocompletion whil
set smarttab "Use shiftwidth number of spaces when doing tabs"

set autoread

runtime macros/matchit.vim "Adds some magic in terms of quick navigation

set backspace=indent,eol,start "Fixes backspace"

set complete-=i

set nrformats-=octal

set ttimeout
set ttimeoutlen=100

set laststatus=2

set history=1000 "Improved history
set tabpagemax=50

set sessionoptions-=options
set viewoptions-=options

set tags+=.tags

if &synmaxcol == 3000
  " Lowering this improves performance in files with long lines.
  set synmaxcol=500
endif
   
if !&scrolloff
  set scrolloff=1
endif

if !&sidescrolloff
  set sidescrolloff=5
endif

set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

set formatoptions+=j " Delete comment character when joining commented lines

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif

if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif

" Skip quickfix window when switching buffers
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup EN

" --- USEFUL KEYBINDINGS --- "
let mapleader = ','

nmap \q :nohlsearch<CR>
nmap \e :e#<CR>
nmap \f :Ack<Space>

" Use the space key to toggle folds
nnoremap <space> za
vnoremap <space> zf

" Go between currently onpened buffers
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Easier switching between buffers
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" Toggle NERDTree
nmap <Leader>n :NERDTreeToggle<CR>
" Show current file in NERDTree
nmap <Leader><Space>n :NERDTreeFind<CR>

" Close buffer without closing a split
map <Leader>w :bp<bar>sp<bar>bn<bar>bd<CR>

" Generate ctags
nnoremap <Leader>ct :silent ! ctags -R --languages=ruby,javascript --exclude=.git --exclude=log --exclude=node_modules -f .tags<cr>

"Go between splits
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

"Copy current file name to system buffer
nmap cp :let @+ = expand("%")<CR>

" --- COLORS ---

" Not sure what it exactly does, but it makes my colors gooood
set termguicolors

" Highlight trailing whitespaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/


" ---- PLUGINS ----"

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'

Plug 'vim-airline/vim-airline' " Bottom line magic

Plug 'tpope/vim-surround'

if has('macunix')
	Plug '/usr/local/opt/fzf' " -- Fuzzy search --
	Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
      
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'tpope/vim-dispatch'
    
Plug 'vim-ruby/vim-ruby' "Extensive ruby support
Plug 'tpope/vim-rails' "Rails magic
Plug 'tpope/vim-rbenv' "Load tags only for current ruby version
Plug 'tpope/vim-bundler' "Looks like it indices all of the gems ctags

Plug 'thoughtbot/vim-rspec' "Run ruby specs

Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

Plug 'slim-template/vim-slim' "Slim templating support

Plug 'dense-analysis/ale' "Smart identation

Plug 'majutsushi/tagbar' "Tagbar

Plug 'tpope/vim-commentary' "Autocommenting feature
Plug 'tpope/vim-endwise' "Add ends wisely

Plug 'tpope/vim-fugitive' "GIT
Plug 'airblade/vim-gitgutter' "GIT Statusline magic

Plug 'vim-scripts/BufOnly.vim'

Plug 'ryanoasis/vim-devicons'

" Color schemes
Plug 'sts10/vim-pink-moon'
Plug 'aswathkk/DarkScene.vim'

call plug#end()

" ---- PLUGINS CONFIGURATION ----"

colorscheme darkscene

" --- NERDTREE --- "

let g:NERDTreeWinPos = "left"
let g:NERDTreeStatusLine = -1

let NERDTreeShowHidden = 1

" --- Airline settings --- "
let g:airline#extensions#tabline#enabled = 1

set hid

" --- FZF --- "
noremap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:ack_use_dispatch=1

" --- ALE --- "

nmap \d :ALEToggleBuffer<CR>
nmap <Leader>f :ALEFix<CR>

let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'

highlight link ALEWarningSign String
highlight link ALEErrorSign Title

nmap ]w :ALENextWrap<CR>
nmap [w :ALEPreviousWrap<CR>

let g:ale_fixers = {'ruby': ['rubocop'], 'xml': ['xmllint']}

augroup vimdiff
	autocmd!
  autocmd VimEnter,FilterWritePre * if &diff | ALEDisable | endif
augroup END

" VIM RSPEC "

map <Leader>s :call RunCurrentSpecFile()<CR>
map <Leader>l :call RunLastSpec()<CR>

nmap \b :TagbarToggle<CR>

let g:rspec_command = "Dispatch bundle exec rspec {spec}"

" --- LANGUAGE SPECIFIC CONFUGRATION --- "

autocmd FileType php setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType yaml,slim,json,vim call SetShiftTwoSpaces()

nmap <Leader><Space>2 :call SetShiftTwoSpaces()<CR>

function SetShiftTwoSpaces()
  setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
endfunction


