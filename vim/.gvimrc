" Remove toolbar
set guioptions-=T

" Themes "{{{
set background=dark
let g:solarized_termcolors=256
colorscheme desert_malthe

"BusyBee
"solarized
"wombat,wombat256,wombat256mod,wombat256malthe
"molokai"let g:molokai_original = 1 |" Less dark background in molokai
"desert

" "}}}

" No bell and no visualbell
set vb t_vb=

" Fonts "{{{

"set guifont=Inconsolata-dz:h11
"set guifont=ProFont:h9
"Inconsolata-dz
"Monaco
"Menlo
"Courier
" References
" http://www.codinghorror.com/blog/2007/10/revisiting-programming-fonts.html
" http://vim.wikia.com/wiki/The_perfect_programming_font)
" http://wiki.macromates.com/Main/AlternativeFonts 

if has("gui_running")
  if has("gui_gtk2")
    command! Small set guifont=ProFont\ 9
    command! Big set guifont=Inconsolata-dz\ for\ Powerline\ 11
    command! Menlo set guifont=Menlo\ for\ Powerline\ 13
  elseif has("gui_macvim")
    command! Small set guifont=ProFontWindows:h9
    command! Big set guifont=Inconsolata-dz\ for\ Powerline:h11
    command! Menlo set guifont=Menlo\ for\ Powerline:h13
  endif
endif

:Small
":Big

" "}}}
