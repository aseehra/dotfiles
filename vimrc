" vim:fdm=marker:foldlevel=0

" Compatibility {{{
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=utf-8,latin1
    set encoding=utf-8
endif

set nocompatible  " Use Vim defaults (much better!)
" }}}

" Plugins {{{
filetype off  " Required for Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'valloric/youcompleteme'
Plugin 'scrooloose/nerdcommenter'
Plugin 'digitaltoad/vim-pug'
Plugin 'w0rp/ale'
Plugin 'aseehra/vim-vue'

call vundle#end()
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

" Buffer management {{{
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

" Syntax Highlighting {{{
let g:ale_linters = {
\     'python': ['prospector'],
\     'javascript': ['eslint']
\   }
" }}}

" Autoformatters {{{
" Python
let g:formatters_python = ['yapf']
let g:formatter_yapf_style = 'google'

noremap <leader>= :Autoformat<CR>
" }}}

" NERDTree {{{
nnoremap <C-n> :NERDTreeToggle<CR>
" }}}

" NERDCommenter {{{
let g:NERDSpaceDelims = 1
"}}}

" Airline {{{
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

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
  autocmd FileType c,cpp,java,objc,javascript setl cin et fdm=syntax tw=100 cc=101 list
  autocmd FileType python setl ai et fdm=indent ts=4 sw=4 cc=81 tw=100 list "Follow PEP 8/Google style
  autocmd BufNewFile,BufRead *.click setl noet
  autocmd FileType json,yaml setl ai et cc=81
  autocmd FileType xml,html setl ai et tw=0 cc=81 list
  " When editing makefiles, set your shiftwidth correctly
  autocmd FileType make setl noet sw=8 ts=8 list
  autocmd FileType zsh,sh setl ai noet ts=4 sw=4 tw=80 cc=81 list
  autocmd FileType gitcommit setl ai et ts=4 sw=4 tw=79 cc=80 list

  " When editing a file, always jump to the last cursor position
  autocmd BufNewFile,BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif
" }}}

" Custom functions {{{
" A oneliner for debuging syntax files
map <F6> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}

