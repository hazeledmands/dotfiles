       " /$$                                                   /$$
      " | $$                                                  | $$
  " /$$$$$$$  /$$$$$$  /$$$$$$/$$$$   /$$$$$$  /$$$$$$$   /$$$$$$$  /$$$$$$$
 " /$$__  $$ /$$__  $$| $$_  $$_  $$ |____  $$| $$__  $$ /$$__  $$ /$$_____/
" | $$  | $$| $$$$$$$$| $$ \ $$ \ $$  /$$$$$$$| $$  \ $$| $$  | $$|  $$$$$$
" | $$  | $$| $$_____/| $$ | $$ | $$ /$$__  $$| $$  | $$| $$  | $$ \____  $$
" |  $$$$$$$|  $$$$$$$| $$ | $$ | $$|  $$$$$$$| $$  | $$|  $$$$$$$ /$$$$$$$/
 " \_______/ \_/%%___/|__/ |__/ |__/ \_______/|__/  |__/ \_______/|_______/
       "      |__/
  " /%%    /%% /%% /%%%%%%/%%%%   /%%%%%%   /%%%%%%%
 " |  %%  /%%/| %%| %%_  %%_  %% /%%__  %% /%%_____/
  " \  %%/%%/ | %%| %% \ %% \ %%| %%  \__/| %%
   " \  %%%/  | %%| %% | %% | %%| %%      | %%
 " /%%\  %/   | %%| %% | %% | %%| %%      |  %%%%%%%
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

" Addon settings ----------------- {{{1
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_open_new_file = 't' " <c-y> opens file in new tab
let g:ctrlp_arg_map = 1 " for <c-z> and <c-o>
let g:ctrlp_user_command = ['.git/', 'git ls-files -co -X .gitignore %s']
let g:ctrlp_use_caching = 0
let NERDTreeMinimalUI=1

" Addons --------------------------------- {{{1

fun! EnsureVamIsOnDisk(plugin_root_dir)
  let vam_autoload_dir = a:plugin_root_dir.'/vim-addon-manager/autoload'
  if isdirectory(vam_autoload_dir)
    return 1
  else
    if 1 == confirm("Clone VAM into ".a:plugin_root_dir."?","&Y\n&N")
      call mkdir(a:plugin_root_dir, 'p')
      execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.
                  \       shellescape(a:plugin_root_dir, 1).'/vim-addon-manager'
      " VAM runs helptags automatically when you install or update 
      " plugins
      exec 'helptags '.fnameescape(a:plugin_root_dir.'/vim-addon-manager/doc')
    endif
    return isdirectory(vam_autoload_dir)
  endif
endfun

fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME/.vim/vim-addons', 1)
  if !EnsureVamIsOnDisk(c.plugin_root_dir)
    echohl ErrorMsg | echomsg "No VAM found!" | echohl NONE
    return
  endif
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'

  let addons = []
  let addons += ['Solarized']                   " color scheme
  let addons += ['ctrlp']                       " fuzzy file-finder
  let addons += ['fugitive']                    " git utilities
  let addons += ['Syntastic']                   " syntax checking on save, etc
  let addons += ['commentary']                  " quickly turn line(s) into comments
  let addons += ['vinegar']                     " <-> to netrc current directory
  let addons += ['endwise']                     " automatically end do/end, if/else, etc structures in ruby, bash, etc
  let addons += ['eunuch']                      " UNIX file utilities like Rename, Move, etc
  let addons += ['github:sjl/vitality.vim']     " play nicely with iTerm2 / tmux
  let addons += ['matchit.zip']                 " multi-char % matching
  let addons += ['abolish']                     " change several variations of a word at a time
  let addons += ['vimux']                       " send commands to other tmux windows
  let addons += ['github:SirVer/ultisnips']     " text snippets
  let addons += ['github:honza/vim-snippets']   " a snippet starter pack
  let addons += ['github:scrooloose/nerdtree']  " file / directory browsing tool

  " filetypes
  let addons += ['github:demands/vim-coffee-script']
  let addons += ['github:wavded/vim-stylus']
  let addons += ['github:groenewege/vim-less']
  let addons += ['jade']
  let addons += ['github:vim-ruby/vim-ruby']
  let addons += ['github:moll/vim-node']

  call vam#ActivateAddons(addons, {'auto_install' : 0})

endfun
call SetupVAM()

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
" noremap <leader>b :TagbarOpenAutoClose<CR>

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
set wildignore+=*.png,*.jpg,*.bmp,*.gif,*.jpeg
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
setglobal nohlsearch " don't highlight search results
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

" Highlight extra whitespace
highlight ExtraWhiteSpace ctermbg=green guibg=green
match ExtraWhiteSpace /\s\+$/

augroup extraWhiteSpace
  autocmd!
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
augroup END

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

" completion options
setglobal complete=.,b,u,d,t

" arrrgh -------- {{{2
augroup arrgh
  autocmd!
  autocmd VimLeave * if v:dying | echo "\nAAAAaaaarrrggghhhh!!!\n" | endif
augroup END

" Custom commands ----------- {{{1

" make arglist all quickfix files
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

" display output of shell command in new buffer
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
    if part[0] =~ '\v[%#<]'
      let expanded_part = fnameescape(expand(part))
      let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
    endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, "You entered:     " . a:cmdline)
  call setline(2, "Expanded form:   " . expanded_cmdline)
  call setline(3, substitute(getline(2),'.','=','g'))
  execute '$read !'.expanded_cmdline
  setlocal nomodifiable
  1
endfunction

" Global key mappings ---- {{{1

" Leader and mapleader keys ---- {{{2
let mapleader = "\<Space>"
let maplocalleader = "\\"

" Save as administrator ---- {{{2
cmap w!! w !sudo tee > /dev/null %

" System clipboard ---- {{{2

" Yank current line / selection to clipboard ---- {{{3
nnoremap <leader>y "*yy
vnoremap <leader>y "*y

" Copy current filename to system clipboard ---- {{{3
nnoremap <leader>f :let @* = expand("%")<CR>

" Insert mode ------ {{{2
" Make 'kj' in insert mode bring you back to edit mode
inoremap kj <Esc>

" toggle paste mode
setglobal pt=<C-q>

" Visual selection ----- {{{2
" Make ,V in normal mode highlight the most recently pasted or edited text
nnoremap ,V `[v`]

" Echo Helpful Information ---- {{{2

" show the entire stack of syntax items affecting the current character
nnoremap <leader>ia :echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), ' => ')<CR>

" show the syntax item that's resulting in the highlighting currently shown
nnoremap <leader>in :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>


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
  call s:QuickFixOpen()

  let @@ = saved_unnamed_register
endfunction

" settings changing -------- {{{2
" local settings ----------- {{{3
" show/hide line numbers ------------- {{{4
noremap <localleader>n :setlocal number!<CR>

" text wrapping ------------- {{{4
noremap <localleader>w :setlocal wrap!<CR>

" show/hide invisibles ------------ {{{4
noremap <localleader>i :setlocal list!<CR>


" toggling foldcolumn (\f) -------- {{{4
nnoremap <localleader>vf :call <sid>FoldColumnToggle()<cr>
function! s:FoldColumnToggle()
  if &foldcolumn
    setlocal foldcolumn=0
  else
    setlocal foldcolumn=4
  endif
endfunction

" global settings ------------------ {{{3
" highlight search ----------------- {{{4
noremap <leader>h :set hlsearch!<CR>

" toggling quickfix (\q) -------- {{{4
nnoremap <leader>q :call <sid>QuickFixToggle()<cr>
let s:quickfix_is_open = 0
function! s:QuickFixOpen()
    let s:quickfix_return_to_window = winnr()
    copen
    let s:quickfix_is_open = 1
endfunction
function! s:QuickFixClose()
    cclose
    let s:quickfix_is_open = 0
    execute s:quickfix_return_to_window . "wincmd w"
endfunction
function! s:QuickFixToggle()
  if s:quickfix_is_open
    call s:QuickFixClose()
  else
    call s:QuickFixOpen()
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

" keys to move between arglist ---- {{{3
nnoremap gn :next<CR>
nnoremap gp :previous<CR>
nnoremap gN :last<CR>
nnoremap gP :first<CR>


" keys to close windows and tabs ---- {{{3
noremap <leader>w :close<CR>
noremap <leader>W :only<CR>

noremap <leader>t :tabclose<CR>
noremap <leader>T :tabonly<CR>

" move between quickfix errors ------- {{{2
nnoremap <C-k> :cprevious<CR>
nnoremap <C-j> :cnext<CR>

" tcsh-style (or emacs style) command mode {{{2
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc><BS> <C-W>

" fugitive mappings ----- {{{2
noremap <Leader>gg :Gstatus<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gsdiff<CR>
noremap <Leader>gp :call VimuxRunCommand("git pull --rebase")<CR>
noremap <Leader>gP :call VimuxRunCommand("git push")<CR>

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

" vmux bindings ------------- {{{2

map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vs :VimuxInterruptRunner<CR>
map <Leader>vc :VimuxClearRunnerHistory<CR>
map <Leader>vz :VimuxZoomRunner<CR>

" NERDTree bindings -------------- {{{2

map <Leader>nf :NERDTreeFind<CR>
map <Leader>nt :NERDTreeToggle<CR>

" Filetype-specific settings -------------- {{{1
" Vimscript --------------------- {{{2
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_css
  autocmd!
  autocmd FileType css setlocal foldmethod=expr
  autocmd FileType css set foldexpr=getline(v:lnum)=~'@group'?'a1':getline(v:lnum)=~'@end'?'s1':'='
augroup END

" Coffeescript -------------- {{{2
augroup filetype_coffee
  autocmd!
  autocmd FileType coffee nnoremap <buffer> <leader>c :CoffeeCompile<CR>
  autocmd FileType coffee vnoremap <buffer> <leader>c :CoffeeCompile<CR>
  autocmd FileType coffee setlocal foldlevel=99

  autocmd BufWritePre *.coffee :%s/\s\+$//e " remove all trailing whitespace
augroup END

" Markdown ------------ {{{2
augroup markdown
  autocmd!
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd FileType markdown set textwidth=80
augroup END


