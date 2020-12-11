" vim:fdm=marker:foldlevel=0

" Compatibility {{{
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=utf-8,latin1
    set encoding=utf-8
endif

set nocompatible  " Use Vim defaults (much better!)
" }}}

" Plugins {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'Chiel92/vim-autoformat'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'digitaltoad/vim-pug'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
call plug#end()
" }}}

" General {{{
filetype plugin indent on
set bs=2  " allow backspacing over everything in insert mode
set ai  " always set auto indenting on
set viminfo='20,\"50  " read/write a .viminfo file, don't store more
set incsearch
set nohlsearch  " no highlighting search
set showmatch
set history=50  " keep 50 lines of command line history
set ruler  " show the cursor position all the time
set et
set sw=2  " set shift tabwidth to 4
set ts=2  " set tabstop to 4
set nowrap  " don't wrap lines
set backupskip=/tmp/crontab.*
set clipboard=unnamed  "use the system clipboard by default
set laststatus=2  "always show the status line
set number
set noerrorbells visualbell t_vb=
set wildmenu
set hidden  "use hidden buffers for ctrl-p goodness

" Make it clear when we have extra characters
set listchars=tab:»\ ,trail:·,extends:›,precedes:‹,nbsp:·
" }}}

" Custom movement {{{
nnoremap j gj
nnoremap k gk

" avoid using ESC
noremap! jk <esc>
" easier to open/close folds
nnoremap <space> za
" }}}

" Code folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
" }}}

" Spellcheck {{{
set spell
set spell spelllang=en_us
set spellfile=~/.vim/spellfile.add
" }}}

" ColorSchemes {{{
" Test to see if we're on a 256-capable terminal
if has("gui_running") || &t_Co >= 256
    let base16colorspace=256
else
    let base16colorspace=0
endif

if &term=="xterm"
    set t_Co=8
    set t_Sb=[4%dm
    set t_Sf=[3%dm
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    " set hlsearch
endif

colorscheme base16-thirtyfivemm-ocean

if has('gui_running') || base16colorspace == "256"
    set cursorline
endif
" }}}

" Linting {{{
let g:ale_linters = {
\     'javascript': ['eslint']
\   }
" }}}

" Autoformatters {{{
" JS: Prettier:
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\ 'javascript': ['prettier', 'eslint'],
\ 'rust': ['rustfmt']
\}
let g:ale_javascript_prettier_options = '--print-width 88'

" Python
let g:formatters_python = ['autopep8']
" let g:formatter_yapf_style = 'pep8'

noremap <leader>= :Autoformat<CR>
" }}}

" NERDTree {{{
nnoremap <C-n> :NERDTreeToggle<CR>
" }}}

" NERDCommenter {{{
let g:NERDSpaceDelims = 1
map gc <Plug>NERDCommenterToggle
"}}}

" Airline {{{
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" let g:airline_inactive_collapse=1
if  base16colorspace == "256" || (has("gui") && !has("gui_macvim"))
    let g:airline_powerline_fonts = 1
endif
" }}}

" Language specific preferences {{{
" Only do this part when compiled with support for autocommands
if has("autocmd")
  " text & text-like files: hard wrap at 80 characters and expand tabs
  autocmd FileType text,markdown setl sw=4 ts=4 et tw=80 cc=81
  autocmd FileType c,cpp,java,objc,javascript setl cin et fdm=syntax tw=88 cc=88 list
  autocmd FileType python setl ai et fdm=indent ts=4 sw=4 cc=89 tw=88 list "Follow PEP 8/Google style
  autocmd BufNewFile,BufRead *.click setl noet
  autocmd FileType json,yaml setl ai et cc=81
  autocmd FileType xml,html setl ai et tw=0 cc=81 list
  " When editing makefiles, set your shiftwidth correctly
  autocmd FileType make setl noet sw=8 ts=8 list
  autocmd FileType zsh,sh setl ai noet ts=4 sw=4 tw=80 cc=81 list
  autocmd FileType gitcommit setl ai et ts=4 sw=4 tw=79 cc=80 list
  autocmd BufNewFile,BufRead *.adoc setl lbr wrap tw=80 cc=81

  " When editing a file, always jump to the last cursor position
  autocmd BufNewFile,BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif
" }}}
