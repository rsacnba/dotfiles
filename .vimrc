call plug#begin('~/.vim/plugged')  " Para Vim

Plug 'preservim/nerdtree'

call plug#end()

syntax off
let mapleader = ","
set incsearch
set ignorecase
set smartcase
set hlsearch
set showmatch
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set history=1000
set termguicolors
set noswapfile
set nobackup
set nowritebackup
set scrolloff=10
set encoding=UTF-8

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
