set nocompatible               " be iMproved

" profile ~/Downloads/vim.log
" profile func *
" profile file *

" Very good resource for scripting Vim
" http://www.ibm.com/developerworks/library/l-vim-script-1/

" Clear augroup vimrc
augroup vimrc
autocmd!
augroup END

" General "{{{

" I use fish as my shell
" fish is not unix-compatible and therefore breaks plugins
set shell=/bin/bash

set encoding=utf8
set fileformat=unix

" Set 256 colors
set t_Co=256
" Fix Vim background color in terminal
" http://sunaku.github.io/vim-256color-bce.html
set t_ut=
" Line numbers
set number
" allows for modified buffers in background
set hidden
" Show command while you're typing
set showcmd
" Show 2 lines of status (needed for Powerline)
set laststatus=2
" Disable bell
set visualbell t_vb=
" Backspace over indents, linebreaks
set backspace=indent,eol,start
" No wrapping of lines
set nowrap
" No automatic insertion of linebreaks in order to wrap text
set wrapmargin=0
" Lines should not wrap automatically
set textwidth=0 " was: 80
" Visual hint for the 80th column
set colorcolumn=81
" Highlight current line
set cursorline
" Don't time out on mapleader mappings etc.
set notimeout
" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" backup
set noswapfile
set backup
set backupdir=~/.vimbackup
if !isdirectory(&backupdir)
  if exists("*mkdir")
    if mkdir(&backupdir)
      echo 'Backup directory `' . &backupdir . '` created.'
    else
      echo 'Could not create backup directory `' . &backupdir . '`.'
    endif
  else
    echo 'Please create the directory: ' . &backupdir
  endif
endif
augroup vimrc
au BufWritePre * let &bex = '-' . strftime("%Y%m%d-%H%M%S") . '.vimbackup'
augroup END



" tabs & indents
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab     " tabs become spaces
set autoindent    " dumb indent
set smartindent   " semi-smart indent
set cindent       " smart indent
"set cinoptions=:s,ps,ts,cs
"set cinwords=if,else,while,do,for,switch,case

" Code folding
set foldlevelstart=99 " don't fold anything on open
set foldopen=block,mark,percent,quickfix,search,tag,undo " don't open folds when
                                                         " moving around
" The above doesn't work as intended
" augroup vimrc
" " Unfold everything on open
" autocmd normal zR
" augroup END


" Python indenting
au FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 "foldcolumn=1

" Match and search
set hlsearch    " highlight search
set ignorecase  " Do case in sensitive matching with
set smartcase   " be sensitive when there's a capital letter
set incsearch

" Unprintable chars mapping
set list
set listchars=tab:»\.,trail:·,extends:»,precedes:« "eol:¶,

" "}}}


" Key mappings/bindings "{{{

" New mapleader
let g:mapleader=','
let g:maplocalleader=','
" We still want the , functionality (repeat last t/f/T/F)
noremap <Bslash> ;
noremap \| ,

" Command mode on Space
nnoremap <Space> :
vnoremap <Space> :
"
" Easily go to the beginning and of line
noremap : $
noremap J ^

function! Righty()
  " Home-row navigation
  noremap j h
  noremap k j
  noremap l k
  noremap ; l
  "Danish
  noremap æ l
  noremap - /

  noremap ,j J

  " Window navigation (splits)
  noremap <C-W>j <C-W>h
  noremap <C-W>k <C-W>j
  noremap <C-W>l <C-W>k
  noremap <C-W>; <C-W>l
endfunction
command! Righty :call Righty()
call Righty()

function! Lefty()
  set textwidth=0
  set wrapmargin=0
  " Home-row navigation
  noremap a h
  noremap s k
  noremap d j
  noremap f l

  " Commands navigation
  noremap j a
  noremap k d
  noremap l s
  noremap ; f

  " Window navigation (splits)
  noremap <C-W>a <C-W>h
  noremap <C-W>s <C-W>j
  noremap <C-W>d <C-W>k
  noremap <C-W>f <C-W>l
endfunction
command! Lefty :call Lefty()
" call Lefty()

" Tab navigation
"noremap <Leader>a :tabprev<CR>
"noremap <Leader>f :tabnext<CR>
noremap <Leader>m :tabprev<CR>
noremap <Leader>. :tabnext<CR>
noremap K :execute "tabmove" tabpagenr() - 2 <CR>
noremap L :execute "tabmove" tabpagenr() <CR>

" My right pinky is sore! - so search with left hand as well
noremap ` /
noremap ~ ?

" Jump back and forth between 2 last positions
noremap '' ``

" <Ctrl-R>a means paste from register _a_. _"_ is the most recent yank.
" So <Ctrl-R><Ctrl-R> now means paste in Insert and Command mode.
" Take a peek at:
" http://stackoverflow.com/questions/4725435/gvim-passing-the-visually-selected-text-to-the-command-line
inoremap <C-R><C-R> <C-R>"
cnoremap <C-R><C-R> <C-R>"

" On the command line <C-B> is beginning of line, but
" that goes contrary to everywhere else where <C-A> is
" beginning of line.
"cnoremap <C-A> <C-B>
" Below is from :help emacs-keys
" See also :help cmdline-editing
"
" start of line
cnoremap <C-A>		<Home>
" back one character
cnoremap <C-B>		<Left>
" delete character under cursor
cnoremap <C-D>		<Del>
" end of line
cnoremap <C-E>		<End>
" forward one character
cnoremap <C-F>		<Right>
" recall newer command-line
cnoremap <C-N>		<Down>
" recall previous (older) command-line
cnoremap <C-P>		<Up>
" back one word
cnoremap <Esc><C-B>	<S-Left>
" forward one word
cnoremap <Esc><C-F>	<S-Right>

"" Search commands
" Remove highlight
nnoremap <silent> <Leader>n :nohl<CR>
" Global search and replace
nnoremap <Leader>/ :%s/
vnoremap <Leader>/ :<Backspace><Backspace><Backspace><Backspace><Backspace>%s/\%V
"
" Show YankRing
nnoremap <Leader>p :YRShow<CR>
" vnoremap <Leader>p :YRShow<CR>

" ctrlp.vim
nnoremap <Leader>f :CtrlP<CR>
" Open in new tab by default
let s:open_in_new_tab_by_default = {
    \ 'AcceptSelection("e")': ['<c-b>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
" Use Malthe's (jkl;) vim movement keys
let s:malthe_movement = {
    \ 'PrtCurLeft()':         ['<c-j>', '<left>', '<c-^>'],
    \ 'PrtSelectMove("j")':   ['<c-k>', '<down>'],
    \ 'PrtSelectMove("k")':   ['<c-l>', '<up>'],
    \ 'PrtCurRight()':        ['<c-;>', '<right>'],
    \ }
let g:ctrlp_prompt_mappings = extend(s:open_in_new_tab_by_default, s:malthe_movement)
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](bower_components|node_modules|public\/build)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
"  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',

" ShowMarks
noremap <silent> <leader>smt :ShowMarksToggle<cr>
noremap <silent> <leader>smo :ShowMarksOn<cr>
noremap <silent> <leader>smd :ShowMarksClearMark<cr>
noremap <silent> <leader>sma :ShowMarksClearAll<cr>
noremap <silent> <leader>smm :ShowMarksPlaceMark<cr>

" "}}}

" Extra commands "{{{

" Easy reloading of vim source files
command! Load source %

" Easy reloading of vim source files
command! SLoad write| source %


" Latex keybinding
augroup vimrc
" Convenience mappings
autocmd FileType tex inoremap <buffer> ; \
autocmd FileType tex inoremap  [[ \begin{
autocmd FileType tex imap <silent> ]] <Plug>LatexCloseCurEnv
autocmd FileType tex noremap  <LocalLeader>ls :call SyncLatex()<CR>
" autocmd FileType tex inoremap <buffer> * \cdot

" Compile on save
" autocmd BufWrite *.tex LatexmkStop| Latexmk
function! StopStartLatexmk()
  silent LatexmkStop
  Latexmk
endfunction
" Auto-compile Latex on save
" autocmd BufWritePost *.tex call StopStartLatexmk()
"
" Vim-Latex: next placeholder
" autocmd FileType tex imap <buffer> <C-s> <C-j>
augroup END

" LaTeX-Box
" let g:LatexBox_latexmk_options = '--shell-escape' " this is for the 'minted'-plugin
" let g:LatexBox_viewer = 'open -a Skim'
" let g:LatexBox_latexmk_options = '-xelatex'
" let g:LatexBox_latexmk_options = ''
let g:LatexBox_Folding = 'yes'
let g:LatexBox_OutputDirectory = 'tex-temp'

" inoremap <buffer> ]] <Plug>LatexCloseLastEnv

function! SyncLatex()
     let execstr = ''
     let execstr .= 'silent !/Applications/Skim.app/Contents/SharedSupport/displayline'
     let execstr .= " " . line('.') . ' "' . LatexBox_GetOutputFile() . '"'
     let execstr .= ' "%:p"'
     " echo execstr
     execute execstr
endfunction
" Thanks for the above to: http://www.charlietanksley.net/philtex/vim-for-latex-part-3/
" Though he uses a single mapping with the escape <C-R> I like mine better

" noremap  <LocalLeader>ls :silent !/Applications/Skim.app/Contents/SharedSupport/displayline line('.') "LatexBox_GetOutputFile()" "%:p"<CR>
" noremap  <LocalLeader>ls :silent !open !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line('.')<CR>
" map  ls :silent !/Applications/Skim.app/Contents/SharedSupport/displayline =line('.') "=LatexBox_GetOutputFile()" "%:p"
" imap <buffer> [[ \begin{
" imap <buffer> ]] <Plug>LatexCloseLastEnv
" nmap <buffer> <F5> <Plug>LatexChangeEnv
" vmap <buffer> <F7> <Plug>LatexWrapSelection
" vmap <buffer> <S-F7> <Plug>LatexWrapSelectionEnv
" map <silent> <Leader>ls :silent !/Applications/Skim.app/Contents/SharedSupport/displayline
"   \ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>" "%:p" <CR>

" tcomment
let g:tcomment_opleader1 = ',c'

" nerdcommenter
let g:NERDCustomDelimiters = { 'haskell': { 'left': '-- ', 'leftAlt': '{-', 'rightAlt': '-}' } }
" autocmd FileType dosbatch autocmd VimEnter * execute "normal \<Plug>NERDCommenterAltDelims"


" "}}}

" Vundle "{{{
" Set filetype OFF so that plugins with ftdetect work
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" My Bundles here:
"
" Themes (colorschemes)
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'wombat256.vim'
Plugin 'desert256.vim'
" Plugin '~/.vim/wombat256malthe'
" Plugin 'zenburn'
Plugin 'darkspectrum'
Plugin 'BusyBee'
Plugin 'epegzz/epegzz.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'phd'
Plugin 'twilight'
" Plugin 'Mustang'
Plugin 'wgibbs/vim-irblack'

" Extensions
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'conormcd/matchindent.vim'
Plugin 'Lokaltog/powerline'
Plugin 'tpope/vim-fugitive'
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'sjbach/lusty'
Plugin 'YankRing.vim'
Plugin 'ShowMarks'
"Plugin 'showmarks2'
Plugin 'IndexedSearch'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'preservim/vim-indent-guides'
"Plugin 'SudoEdit.vim'
Plugin 'gmarik/sudo-gui.vim'
Plugin 'ScrollColors'
" Plugin 'vim-latex'
" Plugin 'file:///Users/Malthe/.vim/AutomaticTexPlugin_12.2', {'sync':'no'}
" Plugin '~/.vim/AutomaticTexPlugin_12.2'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'Rykka/colorv.vim'
" Plugin 'Pyclewn'
"Plugin 'listmaps.vim' |" Lists where (key)maps have been defined but freezes
                        " Vim
Plugin 'mileszs/ack.vim'

" Language-specific
" Plugin 'python_ifold'
Plugin 'Rykka/riv.vim'
Plugin 'petRUShka/vim-opencl'
Plugin 'klen/python-mode'
Plugin 'kchmck/vim-coffee-script'
" Plugin 'tikhomirov/vim-glsl'
Plugin 'Nemo157/glsl.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'leafgarland/typescript-vim'

"" Fish (shell)
" https://github.com/sjl/dotfiles/blob/master/vim/syntax/fish.vim
" Plugin 'aliva/vim-fish'
Plugin 'aliva/vim-fish'

" Smart commands
Plugin 'tomtom/tcomment_vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'godlygeek/tabular'
"Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-repeat'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'assistant'
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-markdown'
Plugin 'skammer/vim-css-color'

" Completion
let g:acp_enableAtStartup=0
" Take a look at:
" http://www.vim.org/scripts/script.php?script_id=2620
" it says to disable AutoComplPop?
Plugin 'AutoComplPop'
Plugin 'ervandew/supertab'
Plugin 'Shougo/neocomplcache'

" Misc
Plugin 'tweekmonster/startuptime.vim'
Plugin 'tpope/vim-endwise'

"Plugin 'L9'           |" FuzzyFinder depends on this
"Plugin 'FuzzyFinder'

" non github repos
"Plugin 'git://git.wincent.com/command-t.git'
call vundle#end()

" Set filetype ON again
filetype plugin indent on
"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin command are not allowed..
" "}}}

" Colorscheme
colorscheme wombat256mod

" ShowMarks
" for an explanation of the marks below see :help `[
"let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'`^{}()\""
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'`"
let g:showmarks_textlower = "\t"
let g:showmarks_textother = "\t"

" Syntastic
noremap <F2> :SyntasticToggleMode<CR>
" syntastic seems to default on submitting html to validator.w3.org which is
" pretty insane: https://github.com/scrooloose/syntastic/issues/515
let g:syntastic_html_checkers=['tidy'] " use tidy instead

" netrw is built-in to Vim, but `elinks -source` which netrw uses on OS X for
" some reason donesn't work
let g:netrw_http_cmd = "curl >"

" LustyJuggler
let g:LustyJugglerSuppressRubyWarning = 1

" Powerline
let g:Powerline_symbols = 'fancy'

" YankRing
let g:yankring_history_dir = expand('$HOME').'/.vim'
nnoremap <silent> <leader>y :YRShow<CR>
" I think that YankRing overrides these, so we have to redefine them
" after YankRing has loaded.
onoremap j h
onoremap k j
onoremap l k
onoremap ; l

" Vim-Latex
 "let g:Tex_ViewRule_pdf = "open -a Skim"
let g:Tex_ViewRule_pdf = "Skim"
let g:Tex_TreatMacViewerAsUNIX = 1
"let g:Tex_ViewRule_pdf = "open !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line('.')"
" let g:Tex_CompileRule_pdf = "pdflatex --shell-escape -interaction=nonstopmode $*"
" let g:Tex_MultipleCompileFormats = "dvi,pdf"
""" http://tex.stackexchange.com/questions/30330/how-can-i-avoid-compiling-twice
" rubber
" latexmk
" texify
let g:Tex_CompileRule_pdf = "latexmk -pdf --shell-escape -interaction=nonstopmode $*"

" PyMode
let g:pymode_lint_cwindow = 0 |" PyMode is great but don't show the error window


" RainbowParentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Autocompletion (from http://github.com/fisadev/fisa-vim-config/blob/master/.vimrc)
" colors and settings of autocompletition
highlight Pmenu ctermbg=4 guibg=LightGray
" highlight PmenuSel ctermbg=8 guibg=DarkBlue guifg=Red
" highlight PmenuSbar ctermbg=7 guibg=DarkGray
" highlight PmenuThumb guibg=Black
" use global scope search
let OmniCpp_GlobalScopeSearch = 1
" 0 = namespaces disabled
" 1 = search namespaces in the current buffer
" 2 = search namespaces in the current buffer and in included files
let OmniCpp_NamespaceSearch = 2
" 0 = auto
" 1 = always show all members
let OmniCpp_DisplayMode = 1
" 0 = don't show scope in abbreviation
" 1 = show scope in abbreviation and remove the last column
let OmniCpp_ShowScopeInAbbr = 0
" This option allows to display the prototype of a function in the abbreviation part of the popup menu.
" 0 = don't display prototype in abbreviation
" 1 = display prototype in abbreviation
let OmniCpp_ShowPrototypeInAbbr = 1
" This option allows to show/hide the access information ('+', '#', '-') in the popup menu.
" 0 = hide access
" 1 = show access
let OmniCpp_ShowAccess = 1
" This option can be use if you don't want to parse using namespace declarations in included files and want to add
" namespaces that are always used in your project.
let OmniCpp_DefaultNamespaces = ["std"]
" Complete Behaviour
let OmniCpp_MayCompleteDot = 0
let OmniCpp_MayCompleteArrow = 0
let OmniCpp_MayCompleteScope = 0
" When 'completeopt' does not contain "longest", Vim automatically select the first entry of the popup menu. You can
" change this behaviour with the OmniCpp_SelectFirstItem option.
let OmniCpp_SelectFirstItem = 0

" autocompletition of files and commands behaves like shell
" (complete only the common part, list the options that match)
" set wildmode=longest:full
"set wildmode=list:longest
set wildmode=longest,list,full
set wildchar=<Tab>
set wildmenu

" AutoComplPop
let g:AutoComplPop_CompleteoptPreview = 1
let g:AutoComplPop_Behavior = {
\ 'c': [ {'command' : "\<C-x>\<C-o>",
\       'pattern' : ".",
\       'repeat' : 0}
\      ],
\ 'php': [ {'command' : "\<C-x>\<C-o>",
\       'pattern' : ".",
\       'repeat' : 0}
\      ]
\}

" Highlight words under cursor
function! HighlightWordUnderCursor()
  let word = matchstr(expand('<cword>'), '[a-zA-Z_0-9]*')
  " echo expand('<cword>')
  " echo word
  if empty(word)
    exe 'match none'
  else
    exe printf('match TabLine /\<%s\>/', escape(expand('<cword>'), '\'))
    " choose a color from this :so $VIMRUNTIME/syntax/hitest.vim
  endif
endfunction

let g:HighlightWordUnderCursor = 1
function! HighlightWordUnderCursorToggle()
  if g:HighlightWordUnderCursor == 1
  let g:HighlightWordUnderCursor = 0
    augroup HighlightWordUnderCursor
    autocmd CursorMoved /* :call HighlightWordUnderCursor()
    "autocmd CursorMoved * silent! :call HighlightWordUnderCursor()
    augroup END
  else
    let g:HighlightWordUnderCursor = 1
    " Remove any current highlighting
    exe 'match none'
    augroup HighlightWordUnderCursor
    " Delete autocmds in group
    autocmd!
    augroup END
  endif
endfunction

command! HighlightWordUnderCursorToggle :call HighlightWordUnderCursorToggle()


" Sudo write
comm! W exec 'w !sudo tee % > /dev/null' | e!

function! ToggleTooLongHL()
  if exists('*matchadd')
    if ! exists("w:TooLongMatchNr")
      let last = (&tw <= 0 ? 80 : &tw)
      let w:TooLongMatchNr = matchadd('ErrorMsg', '.\%>' . (last+1) . 'v', 0)
      echo " Long Line Highlight"
    else
      call matchdelete(w:TooLongMatchNr)
      unlet w:TooLongMatchNr
      echo "No Long Line Highlight"
    endif
  endif
endfunction
noremap <silent> <leader>sl :call ToggleTooLongHL()<cr>

" Pretty-print JSON
command! JSONFormat %!python -m json.tool
"
" Pretty-print XML
command! XMLFormat %!xmllint --format -

" Django helper
vnoremap <leader>i c{% itrans '<ESC>pa' %}<ESC>
vnoremap <leader>t c{% trans '<ESC>pa' %}<ESC>

" F3 Google/code search
function! OnlineDoc()
  if &ft =~ "cpp"
    let s:urlTemplate = "http://doc.trolltech.com/4.1/%.html"
  elseif &ft =~ "ruby"
    let s:urlTemplate = "http://www.ruby-doc.org/core/classes/%.html"
  elseif &ft =~ "perl"
    let s:urlTemplate = "http://perldoc.perl.org/functions/%.html"
  elseif &ft =~ "php"
    let s:urlTemplate = "http://www.php.net/%"
  else
    return
  endif
  "let s:browser = "\"D:\\Applications\\Mozilla Firefox\\firefox.exe\""
  let s:browser = "open -a Opera"
  let s:wordUnderCursor = expand("<cword>")
  let s:url = substitute(s:urlTemplate, "%", s:wordUnderCursor, "g")
  "let s:cmd = "silent !start " . s:browser . " " . s:url
  let s:cmd = "silent !" . s:browser . " " . s:url
  execute s:cmd
  redraw!
endfunction
map <F3> :call OnlineDoc()<CR>

function! StopWrap()
  set textwidth=0
  set wrapmargin=0
endfunction
command! StopWrap :call StopWrap()


" syntax mode setup
let python_highlight_all = 1
let php_sql_query = 1
let php_htmlInStrings = 1

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWSauto()
  " Only remove whitespace if we're not in a git repository
  if !exists(":Git")
    echo "Removing trailing whitespace"
    call DeleteTrailingWS()
  else
    echo "Did not remove trailing whitespace"
  endif
endfunc

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
augroup vimrc
autocmd BufWrite *.py :call DeleteTrailingWSauto()
autocmd BufWrite *.coffee :call DeleteTrailingWSauto()
autocmd BufWrite *.php :call DeleteTrailingWSauto()
autocmd BufWrite *.html :call DeleteTrailingWSauto()
augroup END


augroup filetypedetect
autocmd BufRead,BufNewFile *.cl :setf opencl
autocmd BufRead,BufNewFile *.css_t set filetype=css
augroup END


" diff with original (diff unsaved with saved)
" http://stackoverflow.com/questions/6426154/taking-a-quick-look-at-difforig-then-switching-back
command! DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
nnoremap <Leader>do :DiffOrig<cr>
nnoremap <leader>dc :bd<cr>:diffoff!<cr>:exe "norm! ".g:diffline."G"<cr>

" Choose another colorscheme when diffing
" Old solution:
" au FilterWritePre * if &diff | colorscheme wombat256mod | endif
" New solution:
au BufEnter * if &diff | colorscheme wombat256mod | endif
au BufLeave * if &diff | colorscheme desert_malthe | endif
" au FilterWritePre * if &diff | colorscheme jellybeans | endif
" au FilterWritePre * if &diff | colorscheme molokai | endif

" Return to last edit position when opening files (You want this!)
augroup vimrc
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%

" Easy editing of configuration files
comm! Settings :tabe $MYVIMRC
comm! GSettings :tabe $MYGVIMRC

" source .vimrc on save
augroup vimrc
autocmd BufWritePost *.vim source %
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWritePost $MYGVIMRC source $MYGVIMRC
augroup END



" matching parenthesis
" augroup vimrc
" autocmd CursorMoved *.html call Mymatch()
" augroup END

function! Mymatch()
  echo "hi"
  return
  " execute '2match MatchParen /\%(\%' . lnum2 . 'l\%' . cnum2
  "          \ . 'c' . g:LatexBox_open_pats[i] . '\|\%'
  "          \ . lnum . 'l\%' . cnum . 'c'
  "          \ . g:LatexBox_close_pats[i] . '\)/'
  let pattern = '/\v\%(\%2l\%3cMATCH1|\%4l\%5cMATCH2)/'
  let lnum = line('.')
  let cnum = col('.')
  let pattern = '/\%' . lnum . 'l\%' . cnum . 'ca/'
  let pattern = '/\%' . lnum . 'la/'
  execute '2match MatchParen ' . pattern
endfunction

syntax off


" Tab navigation (the python modules messes this up so reset it)
noremap K :execute "tabmove" tabpagenr() - 2 <CR>
noremap L :execute "tabmove" tabpagenr() <CR>
