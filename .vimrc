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
filetype off
filetype plugin indent on
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

" No tabs when in py files
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4

"Splits motions
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"""""""""KEYMAPS""""""""""""
let mapleader = " "
nnoremap <Leader>u :UndotreeToggle<CR>
nnoremap <Leader>gs :Git<CR>

" System clipboard access
if has("unix")
  let s:uname = system("uname -s")
    if s:uname == "Linux\n"
		nnoremap <Leader>y "+y
		vnoremap <Leader>y "+y
		nnoremap <Leader>Y "+Y
		nnoremap <Leader>ff :Files<CR> 
  else
		nnoremap <Leader>ff :FuzzyFiles<CR> 
		nnoremap <Leader>y "*y
		vnoremap <Leader>y "*y
		nnoremap <Leader>Y "*Y
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
" change all occurrences
nnoremap <Leader>L :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
" change all occurrences but ask
nnoremap <Leader>T :%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>
nnoremap <Leader><Leader> :so $MYVIMRC<CR>
nnoremap <Leader>vs :vs<CR>
nnoremap <Leader>sp :sp<CR>
nnoremap <c-z> <nop> 
nnoremap Q <nop>
nnoremap :W <nop>
nnoremap <Leader>tags :call pathogen#helptags()<CR>
imap jk <Esc>
nnoremap <Leader>nn :NoNeckPain<CR>
nnoremap <Leader>x :!chmod +x %<CR>
nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>:redraw!<CR>

" Terminal mode remaps (edit)-> tmux is the answer
"nnoremap <Leader>vt :vert term<CR>
"nnoremap <Leader>st :term<CR>
"tnoremap <C-h> <C-w>h
"tnoremap <C-j> <C-w>j
"tnoremap <C-k> <C-w>k
"tnoremap <C-l> <C-w>l
"tnoremap <C-n> <C-w>N

" Resize buffers with Alt+Shift+Left/Right Arrows
map <A-S-Left> <C-W>>
map <A-S-Right> <C-W><
map <A-S-Up> <C-W>+
map <A-S-Down> <C-W>-

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
"function! Tab_Or_Complete()
"  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
"    return "\<C-N>"
"  else
"    return "\<Tab>"
"  endif
"endfunction
":inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
":set dictionary="/usr/dict/words"
"""""""""""""""""""""""""

"cursor
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

"python indent
let g:python_recommended_style = 0

""""""""""""P L U G I N  M A N A G E R S """""""""""""""""""""""""""""""""""""""

"""""""""VUNDLE""""""""""""""
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

call vundle#end()            " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""VIM-PLUG"""""""""""
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
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
" THEME
"Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme dracula

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

"""""""""""""""""""""""""" """"""""""""""""""""""""" """""""""""""""""""""""""" 
" LSP settings
let g:lsp_use_native_client = 1
let g:lsp_semantic_enabled = 1
"" YCM begone for now
"let g:ycm_clangd_binary_path = "/nfs/homes/pibouill/bin/clangd"
"" Let clangd fully control code completion
"let g:ycm_clangd_uses_ycmd_caching = 0
"" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
"let g:ycm_clangd_binary_path = exepath("clangd")
"let g:ycm_global_ycm_extra_conf = '~/.config/.ycm_config.ycm_extra_conf.py'

"let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
"nmap <leader>yfw <Plug>(YCMFindSymbolInWorkspace)
"nmap <leader>yfd <Plug>(YCMFindSymbolInDocument)
"""""""""""""""""""""""""""""""
