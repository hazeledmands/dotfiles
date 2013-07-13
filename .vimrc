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

" Vim directories -------------------- {{{1

" Create them if they don't exist ---- {{{2
silent execute '!mkdir -p $HOME/.vimbackup'
silent execute '!mkdir -p $HOME/.vimswap'
silent execute '!mkdir -p $HOME/.vimviews'

" Directories for backups ---- {{{2
setglobal backup
setglobal backupdir=$HOME/.vimbackup//
setglobal directory=$HOME/.vimswap//
setglobal viewdir=$HOME/.vimviews//
if exists("&undodir")
  setglobal undodir=$HOME/.vimundo//
endif

" Vundle bundles --------------------------------- {{{1

" Individual settings ----------------- {{{2
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_clear_cache_on_exit = 0 " retain cache on exit (might mean I have to manually refresh every now and again)
let g:ctrlp_open_new_file = 't' " <c-y> opens file in new tab
let g:ctrlp_arg_map = 1 " for <c-z> and <c-o>
let g:ctrlp_root_markers = ['Gemfile', 'README']
let g:ctrlp_custom_ignore = 'node_modules\|reports'

" The bundles ------------------------ {{{2
setglobal runtimepath+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'demands/vim-potion'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Syntastic'
Bundle 'tpope/vim-commentary'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-markdown'
Bundle 'vim-ruby/vim-ruby'
Bundle 'sjl/vitality.vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'ervandew/supertab'
Bundle 'wikitopian/hardmode'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'edsono/vim-matchit'
Bundle 'kchmck/vim-coffee-script'
Bundle 'wavded/vim-stylus'

" Basic settings ---------------------------- {{{1

" Character encoding (if this is not set, all manner of hell breaks loose when
" LC_CYTPE is set to anything unexpected.)
setglobal encoding=utf-8

" we're running vim, not vi
setglobal nocompatible

" always show the status line, which is made fancy by powerline
setglobal laststatus=2
setglobal statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" don't show the intro message when starting vim
" also, abbreviate a host of other messages that appear on the status line
setglobal shortmess=atIT

" use exuberant ctags
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_compact = 1
noremap <leader>b :TagbarOpenAutoClose<CR>

" optimize for fast terminal connections
setglobal ttyfast

" don't add empty newlines at the end of binary files
setglobal noendofline

" allow mouse input
setglobal mouse=a

" use ag as search program
setglobal grepprg=ag

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
set nonumber

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
setglobal switchbuf+=usetab

" Don't reset cursor to the start of the line when moving around
setglobal nostartofline

" search stuff
setglobal ignorecase " ignore case of searches
setglobal smartcase " ... but don't ignore case if search has uppercase in it
setglobal gdefault " adds the global flag to search/replace by default
setglobal hlsearch " don't highlight search results
setglobal incsearch " highlight dynamically as pattern is typed

" allow cursor beyond last character
setglobal virtualedit=onemore
setglobal virtualedit+=block

" history
setglobal history=1000

" syntax stuff
syntax on " highlighting please

" Syntax coloring
setglobal t_Co=256
setglobal background=dark
let g:solarized_termcolors = 256
let g:solarized_termtrans = 1
colorscheme solarized

" Highlight errors garishly
highlight Error ctermbg=red ctermfg=white guibg=red guifg=white

" Highlight current line
setglobal cursorline
highlight cursorline guibg=#333333
highlight CursorColumn guibg=#333333

" respect modeline in files
setglobal modeline
setglobal modelines=4

" disable error bells
setglobal noerrorbells
setglobal visualbell

" Use the same symbols as TextMate for tabstops and EOLs
setglobal listchars=tab:▸\ ,eol:¬,trail:⋅

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

" hardmode by default -------- {{{2
" augroup default_hardmode
"   autocmd!
"   autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" augroup END

" arrrgh -------- {{{2
augroup arrgh
  autocmd!
  autocmd VimLeave * if v:dying | echo "\nAAAAaaaarrrggghhhh!!!\n" | endif
augroup END

" Global key mappings ---- {{{1

let mapleader = ","
let maplocalleader = "\\"

" Make 'kj' in insert mode bring you back to edit mode
inoremap kj <Esc>

" toggle paste mode
setglobal pt=<C-q>

" Echo Helpful Information ---- {{{2

" show the entire stack of syntax items affecting the current character
nnoremap \ha :echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), ' => ')<CR>

" show the syntax item that's resulting in the highlighting currently shown
nnoremap \hn :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>

" Searching ---- {{{2
nnoremap / /\v
nnoremap ? ?\v

" grep for current operator ---- {{{2
nnoremap <leader>r :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>r :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
  let saved_unnamed_register = @@

  if a:type ==# 'v'
    execute "normal! `<v`>y"
  elseif a:type ==# 'char'
    execute "normal! `[v`]y"
  else
    return
  endif

  silent! execute "grep! -Q " . shellescape(@@)
  redraw!
  copen

  let @@ = saved_unnamed_register
endfunction

" settings changing -------- {{{2

noremap <leader>vn :setlocal number!<CR>
noremap <leader>vw :setlocal wrap!<CR>
noremap <leader>vs :setlocal hlsearch!<CR>
noremap <leader>vh <Esc>:call ToggleHardMode()<CR>

" show/hide invisibles and make trailing whitespace ugly as fuck
noremap <leader>vi :setlocal list<CR>:2match Error /\v\s+$/<CR>
noremap <leader>vI :setlocal nolist<CR>:2match<CR>

" toggling foldcolumn (\f) -------- {{{3
nnoremap <leader>vf :call <sid>FoldColumnToggle()<cr>
function! s:FoldColumnToggle()
  if &foldcolumn
    setlocal foldcolumn=0
  else
    setlocal foldcolumn=4
  endif
endfunction

" toggling quickfix (\q) -------- {{{3
nnoremap <leader>q :call <sid>QuickFixToggle()<cr>
let s:quickfix_is_open = 0
function! s:QuickFixToggle()
  if s:quickfix_is_open
    cclose
    let s:quickfix_is_open = 0
    execute s:quickfix_return_to_window . "wincmd w"
  else
    let s:quickfix_return_to_window = winnr()
    copen
    let s:quickfix_is_open = 1
  endif
endfunction

" Operator-pending mappings ---- {{{2

" reference text inside/around the next/last x --- {{{3
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

" reference text inside next email address ---- {{{3
" the email is: email@address.biz
onoremap in@ :<c-u>execute "normal! /\\c\\w\\+@\\w\\+.\\w\\{1,4}\rv/\<Up>/e\r"<cr>

" Window/tab management -------- {{{2

" keys to create new windows ------ {{{3

" duplicate window --- {{{4
noremap <leader>sl :rightbelow vsplit<CR>
noremap <leader>sh :leftabove vsplit<CR>
noremap <leader>sj :rightbelow split<CR>
noremap <leader>sJ :rightbelow split<CR>G
noremap <leader>sk :leftabove split<CR>
noremap <leader>sK :leftabove split<CR>gg
noremap <leader>st :tabnew<CR>

" new window with previous buffer --- {{{4
noremap <leader>spl :execute 'rightbelow vsplit' bufname('#')<CR>
noremap <leader>sph :execute 'leftabove vsplit' bufname('#')<CR>
noremap <leader>spj :execute 'rightbelow split' bufname('#')<CR>
noremap <leader>spk :execute 'leftabove split' bufname('#')<CR>
noremap <leader>spt :execute 'tabnew' bufname('#')<CR>

" keys to move between windows ------ {{{3
noremap gj <C-w>j
noremap g<down> <C-w>j
noremap gk <C-w>k
noremap g<up> <C-w>k
noremap gl <C-w>l
noremap g<left> <C-w>l
noremap gh <C-w>h
noremap g<right> <C-w>h
noremap g= <C-w>=

" keys to move between tabs ---- {{{3
nnoremap <C-h> gT
nnoremap <C-l> gt

" keys to resize windows ---------- {{{3
noremap + <C-w>+
noremap _ <C-w>-
noremap ) <C-w>>
noremap ( <C-w>>
setglobal equalalways

" move between quickfix errors ------- {{{2
nnoremap <C-j> :cprevious<CR>
nnoremap <C-k> :cnext<CR>

" fugitive mappings ----- {{{2
noremap <Leader>gg :Gstatus<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gdiff<CR>
noremap <Leader>gp :setlocal noconfirm<CR>:Git pull<CR>:bufdo e!<CR>:setlocal confirm<CR>
noremap <Leader>gP :Git push<CR>

" Edit .vimrc (this file) -------------------- {{{2
nnoremap <leader>vv :split ~/.vimrc<CR>
augroup vimrc_settings
  autocmd!

  function! s:loadvimrc()

    function! b:commitvimrc()
      execute 'silent !git commit -am"'.escape(input("Commit message? "), '\!"').'"'
      redraw!
      echom "Push? (Y/n) "
      if nr2char(getchar()) ==# 'Y'
        execute '!git push'
      endif
      redraw!
    endfunction

    setlocal nowrap
    setlocal nonu
    lchdir ~/Dropbox/dotfiles
    nnoremap <buffer> <leader>gg :call b:commitvimrc()<CR>

  endfunction

  autocmd BufRead ~/.vimrc call s:loadvimrc()
  autocmd BufWritePost ~/.vimrc source ~/.vimrc
augroup END

" Filetype-specific settings -------------- {{{1
" Vimscript --------------------- {{{2
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" Coffeescript -------------- {{{2
augroup filetype_coffee
  autocmd!
  autocmd FileType coffee nnoremap <buffer> <leader>c :CoffeeCompile<CR>
  autocmd FileType coffee vnoremap <buffer> <leader>c :CoffeeCompile<CR>
augroup END

" Markdown ------------ {{{2
augroup markdown
  autocmd!
  autocmd FileType mkd onoremap <buffer> ih :<c-u>execute "normal! ?^[=-]\\{2,}$\r:nohlsearch\rkvg_"<cr>
  autocmd FileType mkd onoremap <buffer> ah :<c-u>execute "normal! ?^[=-]\\{2,}$\r:nohlsearch\rg_vk0"<cr>
  autocmd FileType mkd setlocal foldlevel=1
augroup END

