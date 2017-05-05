if has("gui_macvim")
  "set guifont=DejaVu\ Sans\ Mono\ For\ Powerline:h10
  set guifont=Fira\ Code\ Retina:h10
  set macligatures
  set transparency=5
  set blur=20
else
  set guifont=DejaVu\ Sans\ Mono\ For\ Powerline\ 10
  set guioptions-=m
  set guioptions-=T
endif
set lines=60 columns=120
set t_vb= "Stop the screen flashing
set guioptions-=L
