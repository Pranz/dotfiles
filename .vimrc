set nocompatible
filetype off
set t_Co=256
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'Shougo/unite.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'wting/rust.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'dag/vim2hs'
Plugin 'pbrisbin/vim-syntax-shakespeare'
Plugin 'godlygeek/tabular'
Plugin 'kchmck/vim-coffee-script'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'
Plugin 'derekelkins/agda-vim'
Plugin 'klen/python-mode'

call vundle#end()
"call pathogen#infect()
filetype plugin indent on

"pymode
let g:pymode_rope_completion = 1

"start
let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
let g:airline_theme             = 'serene'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1

set laststatus=2
set mouse=a

set tabstop=4
set shiftwidth=4
set expandtab
set hidden
syntax on


set dir=~/.vim/swap

"no folding
set nofoldenable

"highlight search
set hlsearch

"linenumbers
set number
highlight LineNr term=bold cterm=NONE ctermfg=LightGrey ctermbg=DarkGrey gui=NONE guifg=DarkGrey guibg=None

"syntastic
hi SpellBad ctermbg=Black
hi clear Conceal
let g:syntastic_haskell_checkers = ['hlint']

"keys
""bashstuff
let g:BASH_Ctrl_j = 'off'

""more comfortable saving and closing
noremap  <c-s> :update<CR>
inoremap <c-s> <c-o>:update<CR>

noremap  <c-x>      :x<CR>
inoremap <c-x> <c-o>:x<CR>

""tab navigation
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>
inoremap <C-right>   <C-o>:tabnext<CR>
nnoremap <C-right>   :tabnext<CR>
inoremap <C-left> <C-o>:tabprevious<CR>
nnoremap <C-left> :tabprevious<CR>
inoremap <C-up> <C-o>:Unite tab<CR>
nnoremap <C-up> :Unite tab<CR>

""navigation
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

"clear search pattern
nnoremap <C-p> :let @/ = ""<CR>

"NERDTree
inoremap <C-g> <C-o>:NERDTreeToggle<CR>
nnoremap <C-g> :NERDTreeToggle<CR>
