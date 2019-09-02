" ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)
" ============================================================================
" Active plugins
call plug#begin('~/.vim/plugged')

" Plugins from cool guys:

" Tree explorer
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
" Class/module browser
" Plug 'majutsushi/tagbar'
" Code and files fuzzy finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Distraction free
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'
" Visual parenthesis
Plug 'junegunn/rainbow_parenthesis.vim'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Terminal Vim with 256 colors colorscheme
Plug 'fisadev/fisa-vim-colorscheme'
" Pending tasks list
" Plug 'fisadev/FixedTaskList.vim'
" Surround
Plug 'tpope/vim-surround'
" Indent text object
" Plug 'tweekmonster/braceless.vim'
" Indentation based movements
" Plug 'jeetsukumaran/vim-indentwise'
" Python autocompletion, go to definition.
Plug 'davidhalter/jedi-vim'
" Better autocompletion
Plug 'Shougo/neocomplcache.vim'
" Snippets manager (SnipMate), dependencies, and snippets repo
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'
" Plug 'honza/vim-snippets'
" Plug 'garbas/vim-snipmate'
" Git/mercurial/others diff icons on the side of the file lines
" Plug 'mhinz/vim-signify'
" Automatically sort python imports
" Plug 'fisadev/vim-isort'
" Drag visual blocks arround
" Plug 'fisadev/dragvisuals.vim'
" Window chooser
" Plug 't9md/vim-choosewin'
" Python and other languages code checker
" Plug 'scrooloose/syntastic'
" Paint css colors with the real color
" Plug 'lilydjwg/colorizer'
" Python 3.7 syntax
Plug 'vim-python/python-syntax'
if has('python')
    " YAPF formatter for Python
 "    Plug 'pignacio/vim-yapf-format'
endif

" Plugins from vim-scripts repos:

" Search results counter
Plug 'vim-scripts/IndexedSearch'
" XML/HTML tags navigation
Plug 'vim-scripts/matchit.zip'
" Yank history navigation
" Plug 'vim-scripts/YankRing.vim'
" Tetris!
" Plug 'vim-scripts/TeTrIs.vim'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

" no vi-compatible
set nocompatible

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" splits
set splitbelow splitright

" enable folding
set foldmethod=indent
set foldlevel=9

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=2

" mouse
set mouse=a

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4

" always show status bar
set ls=2

" incremental search
set incsearch
" highlighted search results
set hlsearch

" syntax highlight on
syntax on

" show line numbers
set rnu

" tab navigation mappings
map <C-S-Right> :tabn<CR>
tmap <C-S-Right> <c-w>:tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
tmap <C-S-Left> <c-w>:tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" navigate windows with ctrl+arrows
map <C-Right> <c-w>l
map <C-Left> <c-w>h
map <C-Up> <c-w>k
map <C-Down> <c-w>j
tmap <C-Right> <c-w>l
tmap <C-Left> <c-w>h
tmap <C-Up> <c-w>k
tmap <C-Down> <c-w>j
imap <C-Right> <ESC><c-w>l
imap <C-Left> <ESC><c-w>h
imap <C-Up> <ESC><c-w>k
imap <C-Down> <ESC><c-w>j

" my shortcuts from old config
nnoremap <F5> :!clear;python3 %<CR>
nnoremap <C-P> :FZF<CR>
tnoremap <C-W><C-P> <C-W>:FZF<CR>
nnoremap gb :Buffers<CR>
tnoremap <C-W>gb <C-W>:Buffers<CR>
nnoremap gl :Lines<CR>
tnoremap <C-W>gl <C-W>:Lines<CR>
nnoremap <F12> :term<CR>
nnoremap <S-F12> :vert term<CR>
command! ReloadConf source ~/.vimrc
command! EditConf edit ~/.vimrc
nnoremap <space> za
nnoremap <C-Tab> <C-^>

" reopen files on last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" autosave on lost focus
au FocusLost * silent! wa
" %% for current file dir
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" airline tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0

" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
set completeopt-=preview

" save as sudo
ca w!! w !sudo tee "%"

" simple recursive grep
nmap ,r :Ack 
nmap ,wr :Ack <cword><CR>

" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
	let &t_Co = 256
    if ($ITERM_PROFILE == 'Default')
        colorscheme fisa
    else
        colorscheme morning
    endif
else
    colorscheme delek
endif

" when scrolling, keep cursor lines away from screen border
set scrolloff=2

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" Tagbar ----------------------------- 

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" NERDTree ----------------------------- 

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']


" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>

" Syntastic ------------------------------

" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>
" check also when just opened the file
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['python3']
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs = 0
" custom icons (enable them if you use a patched font, and enable the previous 
" setting)
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'

" Jedi-vim ------------------------------

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" NeoComplCache ------------------------------

" most of them not documented because I'm not sure how they work
" (docs aren't good, had to do a lot of trial and error to make 
" it play nice)
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_fuzzy_completion_start_length = 3
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_manual_completion_start_length = 2
let g:neocomplcache_min_keyword_length = 2
let g:neocomplcache_min_syntax_length = 2
" complete with workds from any opened file
let g:neocomplcache_same_filetype_lists = {}
let g:neocomplcache_same_filetype_lists._ = '_'

" TabMan ------------------------------

" mappings to toggle display, and to focus on it
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" DragVisuals ------------------------------

" mappings to move blocks in 4 directions
vmap <expr> <S-M-LEFT> DVB_Drag('left')
vmap <expr> <S-M-RIGHT> DVB_Drag('right')
vmap <expr> <S-M-DOWN> DVB_Drag('down')
vmap <expr> <S-M-UP> DVB_Drag('up')
" mapping to duplicate block
vmap <expr> D DVB_Duplicate()

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

" Python 3.7 syntax for all
let g:python_highlight_all = 1
