set nocompatible              " be iMproved, required
filetype off                  " required

"=====================================================
" Vundle settings
"=====================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'		" let Vundle manage Vundle, required

"---------=== Code/project navigation ===-------------
Plugin 'Shougo/unite.vim' 		" Navigation between buffers and files
Plugin 'majutsushi/tagbar'          	" Class/module browser

"------------------=== Other ===----------------------
Plugin 'fisadev/FixedTaskList.vim' 	" Pending tasks list
Plugin 'rosenfeld/conque-term' 		" Consoles as buffers
Plugin 'tpope/vim-surround'		" Parentheses, brackets, quotes, XML tags, and more

"--------------=== Snippets support ===---------------
Plugin 'garbas/vim-snipmate'		" Snippets manager
Plugin 'MarcWeber/vim-addon-mw-utils'	" dependencies #1
Plugin 'tomtom/tlib_vim'		" dependencies #2
Plugin 'honza/vim-snippets'		" snippets repo

"---------------=== Languages support ===-------------
" --- Python ---
Plugin 'klen/python-mode'	        " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
Plugin 'davidhalter/jedi-vim' 		" Jedi-vim autocomplete plugin
Plugin 'mitsuhiko/vim-jinja'		" Jinja support for vim
Plugin 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim

call vundle#end()            		" required
filetype on
filetype plugin on
filetype plugin indent on

"=====================================================
" General settings
"=====================================================
set backspace=indent,eol,start
" This must happen before the syntax system is enabled
aunmenu Help.
aunmenu Window.
let no_buffers_menu=1
set mousemodel=popup

" Activate a permanent ruler and add line highlightng as well as numbers.
" Also disable the sucking pydoc preview window for the omni completion
" and highlight current line and disable the blinking cursor.
set ruler
set completeopt-=preview
set gcr=a:blinkon0
if has("gui_running")
  set cursorline
endif
set ttyfast

" Enable Syntax Colors
" in GUI mode we go with fruity and Monaco 13
" in CLI mode myterm looks better (fruity is GUI only)
syntax on
if has("gui_running")
" GUI? Then maximize windows and set custom color sheme
  set lines=50 columns=125
  colorscheme molokai
" special settings for vim
if has("mac")
  set guifont=Consolas:h13
  set fuoptions=maxvert,maxhorz
" does not work properly on os x
" au GUIEnter * set fullscreen
else
" set default font for GUI
  set guifont=DejaVu\ Sans\ Mono\ 11
endif
else
" its terminal, setup another theme
  colorscheme myterm
endif

tab sball
set switchbuf=useopen

" Customize the wildmenu
set wildmenu
set wildignore+=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class,*/*.dSYM/*,*.dylib
set wildmode=list:full

" Don't bell and blink
set visualbell t_vb= " turn off error beep/flash
set novisualbell     " turn off visual bell

set enc=utf-8	     " utf-8 default encoding
set ls=2 	     " always show status bar
set incsearch	     " incremental search
set hlsearch	     " highlighted search results
set nu		     " line numbers
set scrolloff=5	     " keep some more lines for scope
 
" Swaps and backups
if has("win32") || has("win64")
  set dir=$TMP
  set backupdir=$TMP
else
  set dir=/tmp
  set backupdir=/tmp
endif

" Hide some panels
"set guioptions-=m   " remove menu bar
set guioptions-=T    " remove toolbar
"set guioptions-=r   " remove right-hand scroll bar

" Tab Settings
set smarttab
set tabstop=8

" Highlight characters past column 80
augroup vimrc_autocmds
    autocmd!
    autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
    autocmd FileType ruby,python,javascript,c,cpp set nowrap
augroup END

" SnipMate settings
let g:snippets_dir = "~/.vim/vim-snippets/snippets"

" Unite settings
nnoremap <F1> :Unite file<CR>	" browse the list of files in the current directory
nnoremap <F2> :Unite buffer<CR> " browse a list of the currently opened buffers

" TaskList settings
map <F3> :TaskList<CR> 	   	" show pending tasks list

" TagBar settings
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0 	" autofocus on Tagbar open

" ConqueTerm
nnoremap <F5> :ConqueTermSplit ipython<CR>			  " run python-scripts at <F5>
nnoremap <F6> :exe "ConqueTermSplit ipython " . expand("%")<CR>   " and debug-mode for <F6>
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 0

"=====================================================
" Python-mode settings
"=====================================================
" Python-mode
" Activate rope
" Keys:
" K Show python docs
" <Ctrl-Space> Rope autocomplete
" <Ctrl-c>g Rope goto definition
" <Ctrl-c>d Rope show documentation
" <Ctrl-c>f Rope find occurrences
" <Leader>b Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[ Jump on previous class or function (normal, visual, operator modes)
" ]] Jump on next class or function (normal, visual, operator modes)
" [M Jump on previous class or method (normal, visual, operator modes)
" ]M Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" Documentation
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="E501,W601,C0110,W0612,E124,E251"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" Syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_options = 0

" Don't autofold code
let g:pymode_folding = 0

" Get possibility to run Python code
let g:pymode_run = 0

"=====================================================
" Jedi-vim
"=====================================================
" Disable choose first function/method at autocomplete
let g:jedi#popup_select_first = 0

"=====================================================
" User hotkeys
"=====================================================
" Easier moving of code blocks
vnoremap < <gv " Shift+> keys
vnoremap > >gv " Shift+< keys

" Backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> " +x
vnoremap <S-Del> " +x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> " +y
vnoremap <C-Insert> " +y

" CTRL-V and SHIFT-Insert are Paste
map <C-V> " +gP
map <S-Insert> " +gP
cmap <C-V> <C-R>+
cmap <S-Insert> <C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature. They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
imap <S-Insert> <C-V>
vmap <S-Insert> <C-V>

" CTRL-Z is Undo
noremap <C-z> u
inoremap <C-z> <C-O>u

" CTRL-Y is Redo
noremap <C-y> <C-R>
inoremap <C-y> <C-O><C-R>

" CTRL-A is Select all
noremap <C-a> gggH<C-O>G
inoremap <C-a> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-a> <C-C>gggH<C-O>G
onoremap <C-a> <C-C>gggH<C-O>G
snoremap <C-a> <C-C>gggH<C-O>G
xnoremap <C-a> <C-C>ggVG

" CTRL-S is Quicksave command
noremap <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <C-O>:update<CR>

" CTRL-O is Quickopen file
noremap <C-o> :browse confirm e<CR>
vnoremap <C-o> :browse confirm e<CR>
inoremap <C-o> :browse confirm e<CR>

" CTRL-O is Quicksave as.. file
noremap <C-w> :browse confirm saveas<CR>
vnoremap <C-w> :browse confirm saveas<CR>
inoremap <C-w> :browse confirm saveas<CR>

" Shift+Arrows to select block/lines
" Activate visual mode in normal mode
nmap <S-Up> V
nmap <S-Down> V
" These are mapped in visual mode
vmap <S-Up> k
vmap <S-Down> j

" Settings for buffers
map <C-q> :bd<CR> 	  " close current buffer
noremap <C-Right> :bn<CR> " move to next buffer
noremap <C-Left> :bp<CR>  " move to previous buffer

" Activate autocomplete at <Ctrl+Space>
inoremap <C-space> <C-x><C-o>

" Generate and insert UUID4 into code by <F12> key
nnoremap <F12> :call InsertUUID4()<CR>

" Python code check on PEP8
autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>

" Easy switching languages
nnoremap <leader>Th :set ft=htmljinja<CR>
nnoremap <leader>Tp :set ft=python<CR>
nnoremap <leader>Tj :set ft=javascript<CR>
nnoremap <leader>Tc :set ft=css<CR>
nnoremap <leader>Td :set ft=django<CR>

"=====================================================
" Languages support
"=====================================================
" --- C/C++/C# ---
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cs setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType c setlocal commentstring=/*\ %s\ */
autocmd FileType cpp,cs setlocal commentstring=//\ %s

" --- CSS ---
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType css setlocal commentstring=/*\ %s\ */

" --- Erlang ---
autocmd FileType erlang setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" --- Go ---
autocmd FileType go setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" --- HTML ---
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" --- Java ---
autocmd FileType java setlocal shiftwidth=2 tabstop=8 softtabstop=2 expandtab
autocmd FileType java setlocal commentstring=//\ %s

" --- JavaScript ---
let javascript_enable_domhtmlcss=1
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd BufNewFile,BufRead *.json setlocal ft=javascript

" --- JSON ---
autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" --- Lua ---
autocmd FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2

" --- Python ---
autocmd FileType python setlocal completeopt-=preview
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" --- reStructuredText ---
autocmd BufNewFile,BufRead *.txt setlocal ft=rst
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
\ formatoptions+=nqt textwidth=74

" --- Ruby ---
autocmd FileType ruby,eruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" --- Vim ---
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" --- template language support (SGML / XML too) ---
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd bufnewfile,bufread *.rhtml setlocal ft=eruby
autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python
autocmd BufNewFile,BufRead *.html,*.htm call s:SelectHTML()
let html_no_rendering=1
let g:closetag_default_xml=1
let g:sparkupNextMapping='<c-l>'
autocmd FileType html,htmldjango,htmljinja,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako source ~/.vim/scripts/closetag.vim

"=====================================================
" User functions
"=====================================================
" Small helper that inserts a random uuid4
" ----------------------------------------
function! InsertUUID4()
python << endpython
if 1:
    import uuid, vim
    s = str(uuid.uuid4())
    cpos = vim.current.window.cursor
    cline = vim.current.line
    vim.current.line = cline[:cpos[1] + 1] + s + cline[cpos[1] + 1:]
    vim.current.window.cursor = (cpos[0], cpos[1] + len(s))
endpython
endfunction

" Define type of html template engine
" ----------------------------------------
fun! s:SelectHTML()
let n = 1
while n < 50 && n < line("$")
" check for jinja
  if getline(n) =~ '{%\s*\(extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
    set ft=htmljinja
    return
  endif
" check for mako
    if getline(n) =~ '<%\(def\|inherit\)'
      set ft=mako
      return
    endif
" check for genshi
    if getline(n) =~ 'xmlns:py\|py:\(match\|for\|if\|def\|strip\|xmlns\)'
      set ft=genshi
      return
    endif
    let n = n + 1
  endwhile
" go with html
  set ft=html
endfun

:nnoremap <F5> "=strftime("%Y-%m-%d %H:%M ")<CR>P
:inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>


" Haskell theme add

if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
elseif &term =~ "rxvt-unicode"
  set t_Co=88
elseif &term =~ "rxvt" || &term =~ "xterm"
  set t_Co=256
elseif has("gui_running")
  set t_Co=256
endif

set cursorline
set cursorcolumn
