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

"""""""""SETS""""""""""""
set number relativenumber
syntax enable
filetype on
filetype plugin on
set mouse=r "Enable mouse click + copy paste
set tabstop=4 "set tab to 4 spaces
set softtabstop=4
set shiftwidth=4
set autoindent
set noexpandtab
set smartindent
set modeline  "make vim change in a specific file
set modelines=5
set ignorecase  "ignore case in search
set incsearch
"set nohlsearch
set history=200
set nocompatible
colorscheme catppuccin_macchiato
set background=dark
set scrolloff=8
set signcolumn=yes
highlight! link SignColumn Normal
set updatetime=50
set colorcolumn=80
set wildmode=longest,list,full
set laststatus=2 " lightline
set noshowmode "lightline too
set nospell "no spelling check (pandoc..)
"Splits
set splitbelow splitright
set omnifunc=syntaxcomplete

"Splits motions
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"""""""""KEYMAPS""""""""""""
let mapleader = " "
nnoremap <Leader>u :UndotreeToggle<CR>
nnoremap <Leader>gs :Git<CR>

if has("unix")
  let s:uname = system("uname -s")
    if s:uname == "Linux\n"
		nnoremap <Leader>ff :Files<CR> 
  else
	  nnoremap <Leader>ff :FuzzyFiles<CR> 
    endif
endif

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <Leader>pv :Ex<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap J mzJ`z
nnoremap <Leader>L :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
nnoremap <Leader><Leader> :so $MYVIMRC<CR>
nnoremap <Leader>vs :vs<CR>
nnoremap <Leader>sp :sp<CR>
nnoremap <c-z> <nop> 
nnoremap <Leader>tags :call pathogen#helptags()<CR>
imap jk <Esc>
nnoremap Q <nop>
nnoremap :W <nop>
nnoremap <Leader>nn :NoNeckPain<CR>
nnoremap <Leader>x :!chmod +x %<CR>
nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>:redraw!<CR>

"Copy to system clipboard - need vim-gtk3 on ubuntu
nnoremap <Leader>y "*y
vnoremap <Leader>y "*y
nnoremap <Leader>Y "*Y

" Terminal mode remaps
"nnoremap <Leader>vt :vert term<CR>
"nnoremap <Leader>st :term<CR>
"tnoremap <C-h> <C-w>h
"tnoremap <C-j> <C-w>j
"tnoremap <C-k> <C-w>k
"tnoremap <C-l> <C-w>l
"tnoremap <C-n> <C-w>N

" resize buffers
map <A-S-Left> <C-W>>
map <A-S-Right> <C-W><
map <A-S-Up> <C-W>+
map <A-S-Down> <C-W>-

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"""""""""""""""""""""""""

"cursor
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

"python indent
let g:python_recommended_style = 0

""""""""PLUGINS"""""""""""
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
"Plug 'vim-syntastic/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug '42Paris/42header'
Plug 'luochen1990/rainbow'
Plug 'preservim/nerdcommenter'
Plug 'ludovicchabant/vim-gutentags'
Plug 'sheerun/vim-polyglot'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'Donaldttt/fuzzyy'
Plug 'wellle/tmux-complete.vim'
"Plug 'shortcuts/no-neck-pain.nvim', { 'tag': '*' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" transparent bg""""""""""""""""
if has('termguicolors')
    set termguicolors
endif

hi Normal guibg=NONE ctermbg=NONE
"""""""""""""""""""""""""""""""

""""""""PLUGINS CONFIG"""""""""

"lightline 
let g:lightline = {
            \'colorscheme': 'rosepine',
            \'component': {
            \   'lineinfo': "%{line('.') . '/' . line('$')}",
            \},
            \}

"42 header
let g:user42 = 'pibouill'
let g:mail42 = 'pibouill@student.42prague.com'

"rainbow parentheses
let g:rainbow_active = 1
let g:rainbow_conf = {
\       'guifgs': ['lightblue', 'lightgreen', 'lightcyan', 'lightyellow']
\    }

"vim-markdown
let g:pandoc#modules#disabled = ["folding"]

"nerdcommenter
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_c = 1
"let b:NERDCustomDelimiters = { 'c': { 'left': '//', 'right': '' } }
let g:NERDSpaceDelims = 0

""""""""""""""""""""""""" coc.nvim
let g:coc_global_extensions = ['coc-json', 'coc-sh', 'coc-markdownlint', 'coc-pyright', 'coc-clangd']

" Function to copy the Coc diagnostic message at the cursor to the clipboard
function! CopyCocErrorToClipboard() abort
  " Get diagnostic information at the cursor position
  let l:diagnostic = CocAction('diagnosticInfo')
  if empty(l:diagnostic)
    echo "No diagnostic information found."
    return
  endif

  " Extract the message and copy it to the clipboard
  let l:message = l:diagnostic['message']
  if empty(l:message)
    echo "No diagnostic message found at the cursor."
    return
  endif

  let @+ = l:message
  echo "Copied to clipboard: " . l:message
endfunction

" Map the function to a key binding, e.g., <leader>ce
nnoremap <silent> <leader>mn :call CopyCocErrorToClipboard()<CR>



"""""""""""""""""""""""""""""""
