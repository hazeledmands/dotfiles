       " /$$                                                   /$$          
      " | $$                                                  | $$          
  " /$$$$$$$  /$$$$$$  /$$$$$$/$$$$   /$$$$$$  /$$$$$$$   /$$$$$$$  /$$$$$$$
 " /$$__  $$ /$$__  $$| $$_  $$_  $$ |____  $$| $$__  $$ /$$__  $$ /$$_____/
" | $$  | $$| $$$$$$$$| $$ \ $$ \ $$  /$$$$$$$| $$  \ $$| $$  | $$|  $$$$$$ 
" | $$  | $$| $$_____/| $$ | $$ | $$ /$$__  $$| $$  | $$| $$  | $$ \____  $$
" |  $$$$$$$|  $$$$$$$| $$ | $$ | $$|  $$$$$$$| $$  | $$|  $$$$$$$ /$$$$$$$/
 " \_______/ \_/$$___/|__/ |__/ |__/ \_______/|__/  |__/ \_______/|_______/ 
       "      |__/                                                          
  " /$$    /$$ /$$ /$$$$$$/$$$$   /$$$$$$   /$$$$$$$                        
 " |  $$  /$$/| $$| $$_  $$_  $$ /$$__  $$ /$$_____/                        
  " \  $$/$$/ | $$| $$ \ $$ \ $$| $$  \__/| $$                              
   " \  $$$/  | $$| $$ | $$ | $$| $$      | $$                              
 " /$$\  $/   | $$| $$ | $$ | $$| $$      |  $$$$$$$                        
" |__/ \_/    |__/|__/ |__/ |__/|__/       \_______/                        
                                                       
" Vim directories -------------------- {{{

" Create them if they don't exist ---- {{{
silent execute '!mkdir -p $HOME/.vimbackup'
silent execute '!mkdir -p $HOME/.vimswap'
silent execute '!mkdir -p $HOME/.vimviews'
" }}}

" Directories for backups ---- {{{
set backup
set backupdir=$HOME/.vimbackup//
set directory=$HOME/.vimswap//
set viewdir=$HOME/.vimviews//
if exists("&undodir")
  set undodir=$HOME/.vimundo//
endif
" }}}

" }}}

" Vundle bundles --------------------------------- {{{

" Ctrl-p settings ----------------- {{{
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_switch_buffer = 2
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_clear_cache_on_exit = 1 " retain cache on exit (might mean I have to manually refresh every now and again)
let g:ctrlp_open_new_file = 't' " <c-y> opens file in new tab
let g:ctrlp_arg_map = 0 " for <c-z> and <c-o>
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_root_markers = ['Gemfile', 'README']
" }}}

set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Syntastic'
Bundle 'tpope/vim-commentary'
Bundle 'mileszs/ack.vim'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-markdown'
Bundle 'vim-ruby/vim-ruby'
Bundle 'sjl/vitality.vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'ervandew/supertab'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'wikitopian/hardmode'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'edsono/vim-matchit'
Bundle 'kchmck/vim-coffee-script'
Bundle 'wavded/vim-stylus'
" }}}

" Basic settings ---------------------------- {{{

" Character encoding (if this is not set, all manner of hell breaks loose when
" LC_CYTPE is set to anything unexpected.)
set encoding=utf-8

" we're running vim, not vi
set nocompatible

" always show the status line, which is made fancy by powerline
set laststatus=2

" don't show the intro message when starting vim
" also, abbreviate a host of other messages that appear on the status line
set shortmess=atIT

" use exuberant ctags
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_compact = 1
noremap <leader>b :TagbarOpenAutoClose<CR>

" optimize for fast terminal connections
set ttyfast

" don't add empty newlines at the end of binary files
set noendofline

" allow mouse input
set mouse=a

" change tabs to two spaces
set expandtab
set tabstop=2

" copy indent from current line when starting a new line
" additionally, follow smart indentation rules for c-like languages
" and for other stuff where cinwords is set
set autoindent
set smartindent
set shiftwidth=2

" indentation in ruby
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case

" enhance command line completion
set wildignore+=doc*,*.png,*.jpg,*.bmp,*.gif,*.jpeg
set wildmenu

" show the cursor position
set ruler

" show the (partial) command as it's being typed
set showcmd

" line numbers (and show/hide them with \n)
set number

" wrapping (off and on with \w; scroll off the window border if close and wrap
" is disabled)
set wrap
set linebreak
set sidescroll=1
set sidescrolloff=20

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" make backspace delete over line breaks, auto indentation, and the place where insert mode began
set backspace=2

" make last line in a window display as much as possible, even if the whole
" thing can't display at once.
set showbreak=⧽
set display=lastline

" when switching betwen buffers, always switch to a preexisting window or tab
" if it's already open
set switchbuf+=usetab

" Don't reset cursor to the start of the line when moving around
set nostartofline

" search stuff
set ignorecase " ignore case of searches
set smartcase " ... but don't ignore case if search has uppercase in it
set gdefault " adds the global flag to search/replace by default
set nohlsearch " don't highlight search results
set incsearch " highlight dynamically as pattern is typed

" allow cursor beyond last character
set virtualedit=onemore
set virtualedit+=block

" history
set history=1000

" syntax stuff
syntax on " highlighting please

" Syntax coloring
set t_Co=256
set background=dark
let g:solarized_termcolors = 256
let g:solarized_termtrans = 1
colorscheme solarized

" Highlight current line
set cursorline
hi cursorline guibg=#333333
hi CursorColumn guibg=#333333

" respect modeline in files
set modeline
set modelines=4

" disable error bells
set noerrorbells
set visualbell

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:⋅

" enable filetype detection
filetype on
filetype indent on
filetype plugin on

" syntastic error checking
let g:syntastic_auto_loc_list=1 " auto open error window when errors are detected
let g:syntastic_check_on_open=1 " check for errors on file open
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
noremap <leader>e :SyntasticCheck<CR>:Errors<cr><C-w>j
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'active_filetypes': ['ruby', 'php', 'coffee'],
                            \ 'passive_filetypes': ['html'] }

" hardmode by default -------- {{{
augroup default_hardmode
  autocmd!
  autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
augroup END
" }}}

" }}}

" Global key mappings ---- {{{

let mapleader = ","

" Make 'kj' in insert mode bring you back to edit mode
inoremap kj <Esc>

" toggle paste mode
set pt=<C-q>


" settings changing -------- {{{

noremap \h <Esc>:call ToggleHardMode()<CR>
noremap \n :setlocal number!<CR>
noremap \w :setlocal wrap!<CR>
noremap \s :setlocal hlsearch!<CR>

" show/hide invisibles
noremap \i :setlocal list!<CR>

" }}}

" Operator-pending mappings ---- {{{

" reference text inside/around the next/last x --- {{{
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap al( :<c-u>normal! F)va(<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap il[ :<c-u>normal! F]vi[<cr>
onoremap an[ :<c-u>normal! f[va[<cr>
onoremap al[ :<c-u>normal! F]va[<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
onoremap an{ :<c-u>normal! f{va{<cr>
onoremap al{ :<c-u>normal! F}va{<cr>
onoremap in" :<c-u>normal! f"vi"<cr>
onoremap il" :<c-u>normal! F"vi"<cr>
onoremap an" :<c-u>normal! f"va"<cr>
onoremap al" :<c-u>normal! F"va"<cr>
onoremap in' :<c-u>normal! f'vi'<cr>
onoremap il' :<c-u>normal! F'vi'<cr>
onoremap an' :<c-u>normal! f'va'<cr>
onoremap al' :<c-u>normal! F'va'<cr>
" }}}

" reference text inside next email address ---- {{{
" the email is: email@address.biz
onoremap in@ :<c-u>execute "normal! /\\w\\+@\\w\\+.\\w\\{1,4}\rv/\<Up>/e\r"<cr>
" }}}

" }}}

" Window/tab management -------- {{{

" keys to create new windows ------ {{{
noremap <leader>sl :vsplit<CR><C-W>l
noremap <leader>sh :vsplit<CR><C-W>h
noremap <leader>sj :split<CR><C-W>j
noremap <leader>sJ :split<CR><C-W>jG
noremap <leader>sk :split<CR>
noremap <leader>sK :split<CR>gg
noremap <leader>t :tabnew<CR>
" }}}

" keys to move between windows ------ {{{
noremap gj <C-w>j
noremap gk <C-w>k
noremap gl <C-w>l
noremap gh <C-w>h
noremap g= <C-w>=
" }}}

" keys to move between tabs ---- {{{
nnoremap <C-h> gT
nnoremap <C-l> gt
" }}}

" keys to resize windows ---------- {{{
noremap + <C-w>+
noremap _ <C-w>-
noremap ) <C-w>>
noremap ( <C-w>>
set equalalways
" }}}

" }}}

" move between quickfix errors ------- {{{
nnoremap <C-j> :cp<CR>
nnoremap <C-k> :cn<CR>
" }}}

" fugitive mappings ----- {{{
noremap <Leader>gg :Gstatus<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gdiff<CR>
noremap <Leader>gp :set noconfirm<CR>:Git pull<CR>:bufdo e!<CR>:set confirm<CR>
noremap <Leader>gP :Git push<CR>
" }}}

" Edit .vimrc (this file) -------------------- {{{
noremap \v :sp ~/.vimrc<CR>
augroup vimrc_settings
  autocmd!
  autocmd BufRead ~/.vimrc setlocal nowrap
  autocmd BufRead ~/.vimrc setlocal nonu
  autocmd BufWritePost ~/.vimrc source ~/.vimrc
augroup END
" }}}

" }}}

" Filetype-specific settings -------------- {{{
" Vimscript --------------------- {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Coffeescript -------------- {{{
augroup filetype_coffee
  autocmd!
  autocmd FileType coffee nnoremap <buffer> <leader>c :CoffeeCompile<CR>
  autocmd FileType coffee vnoremap <buffer> <leader>c :CoffeeCompile<CR>
augroup END
" }}}

" Markdown ------------ {{{
augroup markdown
  autocmd!
  autocmd FileType mkd onoremap <buffer> ih :<c-u>execute "normal! ?^[=-]\\{2,}$\r:nohlsearch\rkvg_"<cr>
  autocmd FileType mkd onoremap <buffer> ah :<c-u>execute "normal! ?^[=-]\\{2,}$\r:nohlsearch\rg_vk0"<cr>
augroup END
" }}}
" }}}
