" autoinstall airline fonts
if empty(glob('~/.config/nvim/fonts'))
  !git clone https://github.com/powerline/fonts.git ~/.config/nvim/fonts
  !~/.config/nvim/fonts/install.sh
endif
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

set encoding=utf-8
set guifont=Source\ Code\ Pro\ for\ Powerline "make sure to escape the spaces in the name properly
set nocompatible
set binary

" presentation settings
set number              " precede each line with its line number
set numberwidth=3       " number of culumns for line numbers
set textwidth=0         " Do not wrap words (insert)
set nowrap              " Do not wrap words (view)
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ruler               " line and column number of the cursor position
set wildmenu            " enhanced command completion
set visualbell          " use visual bell instead of beeping
set laststatus=2        " always show the status lines
set list listchars=tab:→\ ,trail:▸
set cursorline   " highlight current line
set cursorcolumn " highlight current column
set clipboard=unnamed
set autoindent
set history=1000
" highlight spell errors
hi SpellErrors guibg=red guifg=black ctermbg=red ctermfg=black
" toggle spell check with F7
map <F7> :setlocal spell! spell?<CR>

" search settings
set incsearch           " Incremental search
set hlsearch            " Highlight search match
set ignorecase          " Do case insensitive matching
set smartcase           " do not ignore if search pattern has CAPS

" directory settings
set nobackup            " do not write backup files
set noswapfile          " do not write .swp files
if has("persistent_undo")
  silent !mkdir -vp ~/.backup/vim/undo/ > /dev/null 2>&1
  set backupdir=~/.backup/vim,.       " list of directories for the backup file
  set directory=~/.backup/vim,~/tmp,. " list of directory names for the swap file
  set undofile
  set undodir=~/.backup/vim/undo/,~/tmp,.
endif

" <F2> toggles paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

let mapleader = ","
let maplocalleader = "\\"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='wombat'
let g:ctrlp_map = '<c-t>'
let g:ctrlp_cmd = 'CtrlP'
let g:deoplete#enable_at_startup = 1

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
call plug#begin('~/.config/nvim/plugged')
Plug 'ekalinin/Dockerfile.vim'
Plug 'sheerun/vim-polyglot'
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_cache_dir = '~/.tags_cache'
let $MIX_ENV = 'test'
Plug 'neomake/neomake'
autocmd! BufWritePost * Neomake
"Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'slashmili/alchemist.vim'
let g:alchemist_tag_disable = 1
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Tab complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/Align'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-dispatch'
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
Plug 'vim-scripts/camelcasemotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'endel/vim-github-colorscheme'
Plug 'vim-scripts/twilight256.vim'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'floobits/floobits-neovim'
Plug 'vim-scripts/file-line'
Plug 'vim-scripts/LargeFile'
Plug 'StanAngeloff/php.vim'
Plug 'evidens/vim-twig'
Plug 'kassio/neoterm'
Plug 'airblade/vim-gitgutter'
call plug#end()

set t_Co=256
let g:solarized_terVmtrans = 1
set background=dark

" ,/ to invert comment on the current line/selection
nmap <leader>/ :call NERDComment(0, "invert")<cr>
vmap <leader>/ :call NERDComment(0, "invert")<cr>
" ,e for Ggrep
  nmap <leader>g :silent Ggrep
  " ,f for global git search for word under the cursor (with highlight)
  nmap <leader>f :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>

  " same in visual mode
  :vmap <leader>f y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:cw<CR><CR>

" Tabs
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab
" for moving between split windows with ease:
" up one window, maximized
map <C-j> <C-w>j<C-w>80+
" down one window, maximized
map <C-k> <C-w>k<C-w>80+
" maximize current window
map <C-h> <C-w>80+
" all windows equal height
map <C-i> <C-w>=
" bump size
map <Leader><Left> :vertical resize -15<cr><Leader>
map <Leader><Right> :vertical resize +15<cr><Leader>
map <Leader><S-Up> :vertical resize 15><cr><Leader>
map <Leader><S-Down> :vertical resize 15<<cr><Leader>

function! OutdoorMode()
  colorscheme github
endfunction

function! NormalMode()
    colorscheme twilight256
endfunction


command! OutdoorMode :call OutdoorMode()
command! NormalMode :call NormalMode()


" Don't use Ex mode, use Q for formatting
map Q gq

"make Y consistent with C and D
nnoremap Y y$

" toggle highlight trailing whitespace
nmap <silent> <leader>s :set nolist!<CR>

" Ctrl-N to disable search match highlight
nmap <silent> <C-N> :silent noh<CR>

" Ctrol-E to switch between 2 last buffers
nmap <C-E> :b#<CR>

" ,e to fast finding files. just type beginning of a name and hit TAB
nmap <leader>e :e **/

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" ,n to get the next location (compilation errors, grep etc)
nmap <leader>n :cn<CR>
nmap <leader>N :cp<CR>

"set completeopt=menuone,preview,longest
set completeopt=menuone,preview

" center display after searching
nnoremap n   nzz
nnoremap N   Nzz
nnoremap *   *zz
nnoremap #   #zz
nnoremap g*  g*zz
nnoremap g#  g#z

""""""""""" awesome stuff from vimbits.com

" keep selection after in/outdent
vnoremap < <gv
vnoremap > >gv

" better navigation of wrapped lines
nnoremap j gj
nnoremap k gk

" easier increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" remove trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" easy split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Type <F1> follwed by a buffer number or name fragment to jump to it.
" Also replaces the annoying help button. Based on tip 821.
map <F1> :ls<CR>:b<Space>
set mouse=a
let g:NERDTreeMouseMode=1


try
	colorscheme twilight256
catch
endtry

syntax enable
filetype plugin indent on
filetype on
