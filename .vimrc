"                              ____
"               ,---,        ,'  , `.,-.----.     ,----..
"       ,---.,`--.' |     ,-+-,.' _ |\    /  \   /   /   \
"      /__./||   :  :  ,-+-. ;   , ||;   :    \ |   :     :
" ,---.;  ; |:   |  ' ,--.'|'   |  ;||   | .\ : .   |  ;. /
"/___/ \  | ||   :  ||   |  ,', |  ':.   : |: | .   ; /--`
"\   ;  \ ' |'   '  ;|   | /  | |  |||   |  \ : ;   | ;
" \   \  \: ||   |  |'   | :  | :  |,|   : .  / |   : |
"  ;   \  ' .'   :  ;;   . |  ; |--' ;   | |  \ .   | '___
"   \   \   '|   |  '|   : |  | ,    |   | ;\  \'   ; : .'|
"    \   `  ;'   :  ||   : '  |/     :   ' | \.''   | '/  :
"     :   \ |;   |.' ;   | |`-'      :   : :-'  |   :    /
"      '---" '---'   |   ;/          |   |.'     \   \ .'
"                    '---'           `---'        `---`

"SETS
set number relativenumber
syntax enable
filetype on
filetype plugin on
set mouse=r							" Enable mouse click + copy paste
set tabstop=4						" set tab to 4 spaces
set softtabstop=4
set shiftwidth=4
set autoindent
set noexpandtab
set smartindent
set modeline	" make vim change in a specific file
set modelines=5
set ignorecase	"ignore case in search
set incsearch
"set nohlsearch
colorscheme catppuccin_macchiato
set termguicolors
set background=dark
set scrolloff=8
set signcolumn=yes
set updatetime=50
set colorcolumn = "80"
set wildmode=longest,list,full
set laststatus=2 " lightline
set noshowmode "lightline too
"Splits
set splitbelow splitright
set omnifunc=syntaxcomplete
"Splits motions
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"KEYMAPS
let mapleader = " "
nnoremap <Leader>u :UndotreeToggle<CR>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>ff :Files<CR> 
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <Leader>pv :Ex<CR>
vnoremap J :m '>+1<CR>gv=gv'
vnoremap K :m '<-2<CR>gv=gv'
nnoremap J mzJ`z
nnoremap <Leader>L :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
nnoremap <Leader><Leader> :so $MYVIMRC<CR>
nnoremap <Leader>vs :vs<CR>
nnoremap <Leader>sp :sp<CR>
nnoremap <c-z> <nop>
nnoremap <leader>s :w<CR>
imap jk <Esc>
"disable ctrl+z


"cursor
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

"PLUG MANAGER
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"PLUGINS
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'vim-syntastic/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug '42Paris/42header'
Plug 'luochen1990/rainbow'
Plug 'preservim/nerdcommenter'
Plug 'craigemery/vim-autotag'
Plug 'sheerun/vim-polyglot'
call plug#end()

" transparent bg""""""""""""""""""
if has('termguicolors')
    set termguicolors
endif

hi Normal guibg=NONE ctermbg=NONE
""""""""""""""""""""""""""""""""""

"lightline 
let g:lightline = {
            \'colorscheme': 'rosepine',
            \'component': {
            \   'lineinfo': "%{line('.') . '/' . line('$')}",
            \},
            \}

let g:user42 = 'pibouill'
let g:mail42 = 'pibouill@student.42prague.com'
let g:rainbow_active = 1
let g:rainbow_conf = {
\       'guifgs': ['lightblue', 'lightgreen', 'lightcyan', 'lightyellow']
\    }
