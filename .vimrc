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

nnoremap <silent> m<Leader><Leader> :edit $MYVIMRC<cr>
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
Plug 'tpope/vim-dispatch' " Ability to dispatch commands

Plug 'preservim/vimux' " Tmux integration
    
Plug 'vim-ruby/vim-ruby' "Extensive ruby support
Plug 'tpope/vim-rails' "Rails magic
Plug 'tpope/vim-rbenv' "Load tags only for current ruby version
Plug 'tpope/vim-bundler' "Looks like it indices all of the gems ctags

Plug 'thoughtbot/vim-rspec' "Run ruby specs

Plug 'kana/vim-textobj-user' "Textobject
Plug 'nelstrom/vim-textobj-rubyblock'

Plug 'moll/vim-node'
Plug 'tomlion/vim-solidity'
Plug 'leafgarland/typescript-vim'

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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }


Plug 'autozimu/LanguageClient-neovim', { 'do': 'bash install.sh' }


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

let g:ale_fixers = {'ruby': ['rubocop'], 'xml': ['xmllint'], 'json': ['jq'], 'javascript': ['eslint'], 'typescript': ['eslint']}

augroup vimdiff
	autocmd!
  autocmd VimEnter,FilterWritePre * if &diff | ALEDisable | endif
augroup END

" --- Deoplete (autocompletion) ---
let g:deoplete#enable_at_startup = 1

call deoplete#custom#source('LanguageClient',
            \ 'min_pattern_length',
            \ 2)


" --- VIM TESTS ---

" Runs whole file
nmap <silent> <leader>s :TestNearest<CR>

" let test#strategy = "dispatch"
let g:test#javascript#runner = 'mocha'

let test#javascript#mocha#options = "APP_ENV=test"

" Runs last spec
" map <Leader>S :call RunLastSpec()<CR>
" Runs nearest spec in the whole file
" map <Leader><Space>s :call RunNearestSpec()<CR>


" " VIM RSPEC

" " Runs whole file
" map <Leader>s :call RunCurrentSpecFile()<CR>
" " Runs last spec
" map <Leader>S :call RunLastSpec()<CR>
" " Runs nearest spec in the whole file
" map <Leader><Space>s :call RunNearestSpec()<CR>

let g:rspec_command = "VimuxRunCommand 'bundle exec rspec {spec}'"

" --- Markdown ---
let vim_markdown_preview_github = 1
let vim_markdown_preview_browser='Brave Browser'

" --- TAGBAR ---

nmap \b :TagbarToggle<CR>

" --- LANGUAGE CLIENT  ---

" TODO: add solidity ?
let g:LanguageClient_serverCommands = { 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
        \'typescript': ['/Users/nick/.nodenv/shims/typescript-language-server', '--stdio'],
        \'javascript': ['/Users/nick/.nodenv/shims/typescript-language-server', '--stdio'],
        \}

" Awesome mappings for LanguageClient
nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>

nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>lX :call OpenLanguageClientSelectionUIQuickFix()<CR>

nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>

let g:LanguageClient_diagnosticsList='Disabled'

"  Probably there is a better way for all of this. "
let g:useQuickFixForCustomLanagueClientSelectionUI=0

" Adds ability to search references both in quickfix and fzf window
function! CustomLanguageClientSelectionUI(source, sink) abort
  if g:useQuickFixForCustomLanagueClientSelectionUI
    cexpr a:source
    copen
  else
    if exists('*fzf#vim#with_preview')
      let l:options = fzf#vim#with_preview('right:50%:hidden', '?').options
    else
      let l:options = []
    endif

    call fzf#run(fzf#wrap({
          \ 'source': a:source,
          \ 'sink': function(a:sink),
          \ 'options': l:options,
          \ }))

    if has('nvim') && !has('nvim-0.4')
      call feedkeys('i')
    endif
  endif

  let g:useQuickFixForCustomLanagueClientSelectionUI=0
endfunction

let g:LanguageClient_selectionUI = function('CustomLanguageClientSelectionUI')

function OpenLanguageClientSelectionUIQuickFix() 
  let g:useQuickFixForCustomLanagueClientSelectionUI=1
  call LanguageClient#textDocument_references()
endfunction

" --- Tree Sitter (Advanced highlighting)

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "javascript", "ruby" },
  sync_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    }
  }
}
EOF

" --- LANGUAGE SPECIFIC CONFUGRATION --- "

autocmd FileType php,solidity setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType typescript,javascript,yaml,slim,json,vim,scss call SetShiftTwoSpaces()

nmap <Leader><Space>2 :call SetShiftTwoSpaces()<CR>

function SetShiftTwoSpaces()
  setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
endfunction


