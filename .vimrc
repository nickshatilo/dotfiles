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

set rnu " Relative line numbers

set autoread

runtime macros/matchit.vim "Adds some magic in terms of quick navigation

set backspace=indent,eol,start "Fixes backspace

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

nmap \<Space> :%s/\s\+$//e<CR>

" Use the space key to toggle folds
nnoremap <space> za
vnoremap <space> zf

" Go between currently onpened buffers
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Toggle NERDTree
nmap <Leader>n :NERDTreeToggle<CR>
" Show current file in NERDTree
nmap <Leader><Space>n :NERDTreeFind<CR>

" Close buffer without closing a split
map <Leader>w :bp<bar>sp<bar>bn<bar>bd<CR>

" Generate ctags
nnoremap <Leader>ct :silent ! ctags -R --languages=ruby,javascript --exclude=.git --exclude=log --exclude=node_modules -f .tags<cr>
nnoremap <Leader>crt :silent ! ripper-tags -f .tags<cr>

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

" --- RELOAD MY VIM CONFIG --- 

nnoremap <silent> <Leader><Leader> :source $MYVIMRC<cr>

" ---- PLUGINS ----"

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'

Plug 'vim-airline/vim-airline' " Bottom line magic

Plug 'tpope/vim-surround'

if has('macunix')
	Plug '/opt/homebrew/opt/fzf' " -- Fuzzy search --
	Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
      
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'tpope/vim-dispatch'

Plug 'preservim/vimux'
    
Plug 'vim-ruby/vim-ruby' "Extensive ruby support
Plug 'tpope/vim-rails' "Rails magic
Plug 'tpope/vim-rbenv' "Load tags only for current ruby version
Plug 'tpope/vim-bundler' "Looks like it indices all of the gems ctags

Plug 'thoughtbot/vim-rspec' "Run ruby specs

Plug 'kana/vim-textobj-user' "Textobject
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

Plug 'mattn/emmet-vim'

" Color schemes
Plug 'sts10/vim-pink-moon'
Plug 'aswathkk/DarkScene.vim'
Plug 'ayu-theme/ayu-vim'

" Markdown support
Plug 'gabrielelana/vim-markdown'
Plug 'JamshedVesuna/vim-markdown-preview'

call plug#end()

" ---- PLUGINS CONFIGURATION ----"

let ayucolor="mirage" " for mirage version of theme

" colorscheme darkscene
colorscheme ayu

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

let g:ale_fixers = {'ruby': ['rubocop'], 'xml': ['xmllint'], 'json': ['jq']}

augroup vimdiff
	autocmd!
  autocmd VimEnter,FilterWritePre * if &diff | ALEDisable | endif
augroup END

" VIM RSPEC

" Runs whole file
map <Leader>s :call RunCurrentSpecFile()<CR>
" Runs last spec
map <Leader>S :call RunLastSpec()<CR>
" Runs nearest spec in the whole file
map <Leader><Space>s :call RunNearestSpec()<CR>

let g:rspec_command = "VimuxRunCommand 'bundle exec rspec {spec}'"

" --- Markdown ---
let vim_markdown_preview_github = 1
let vim_markdown_preview_browser='Brave Browser'

" --- TAGBAR ---

nmap \b :TagbarToggle<CR>

" --- LANGUAGE SPECIFIC CONFUGRATION --- "

autocmd FileType php setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType javascript,yaml,slim,json,vim,scss call SetShiftTwoSpaces()

nmap <Leader><Space>2 :call SetShiftTwoSpaces()<CR>

function SetShiftTwoSpaces()
  setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
endfunction

