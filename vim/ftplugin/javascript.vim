setl cin
setl expandtab
setl foldmethod=syntax
setl textwidth=88
setl colorcolumn=89
setl list

" Linting

let b:ale_linters = ['eslint']

" Prettier
let b:ale_fix_on_save = 1
let b:ale_fixers = ['prettier']
let b:ale_javascript_prettier_options = '--print-width 88'
