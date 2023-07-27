" github.com/gmarik/vundle
set nocompatible
filetype off
set noswapfile "embrace life on the edge

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
"Plugin 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
Plugin 'sukima/xmledit'
" Plugin 'vim-scripts/HTML-AutoCloseTag'
"^ Great! automatically closes tabs? But this breaks dts in md
" replace with below
Plugin 'alvan/vim-closetag'
"Plugin 'kien/ctrlp.vim'
"Plugin 'wincent/Command-T'

" "Plugin 'taglist.vim'
" "Plugin 'django.vim'
" "Plugin 'scons.vim'
" "Plugin 'sjl/gundo.vim.git'
Plugin 'vim-scripts/greplace.vim'
" Plugin 'mbbill/undotree'
 
" HERE

"https://github.com/garbas/vim-snipmate
"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

Plugin 'AnsiEsc.vim'

" threesome
"Plugin 'sjl/splice.vim'

Plugin 'JuliaLang/julia-vim'

" Plugin 'Valloric/YouCompleteMe'

Plugin 'scrooloose/nerdtree'
"
"Plugin 'godlygeek/tabular'
" Plugin 'plasticboy/vim-markdown'
" ^ Syntax highlighting for code in markdown
"
"Plugin 'autotag'
"
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'jpalardy/vim-slime'

Plugin 'lervag/vimtex'

"Plugin 'szymonmaszke/vimpyter'

Plugin '907th/vim-auto-save'

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'yorickpeterse/vim-paper.git'

" Plugin 'Rykka/clickable.vim'
" Plugin 'Rykka/clickable-things'

call vundle#end()

" http://vim.wikia.com/wiki/Insert_current_date_or_time
iabbrev <expr> dts strftime("%c")

filetype plugin indent on

colorscheme desert256
hi link matlabCellComment matlabComment

inoremap <C-space> <C-p>
inoremap <C-@> <C-p>
" inoremap <C-space> <C-x><C-o>

set smartindent
set number

set gfn=Monospace\ 10

" http://ubuntuforums.org/showthread.php?t=782136
" cmap w! ! %!sudo tee > /dev/null %

" http://statico.github.com/vim.html
noremap j gj
noremap k gk
nmap \e :NERDTreeToggle<CR>

"http://facwiki.cs.byu.edu/nlp/index.php/Vim%2BLaTeX_on_Linux
" let g:Tex_ViewRule_pdf = 'okular'

" tex specific wordwrap
au BufRead,BufNewFile *.tex set wrap|set linebreak|set nolist
au BufRead,BufNewFile *.txt set wrap|set linebreak|set nolist
au BufRead,BufNewFile *.md set wrap|set linebreak|set nolist

"https://github.com/alvan/vim-closetag
let g:closetag_filetypes = 'html,xhtml,phtml,md'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.md'

"try the bufread approach instead
au BufRead,BufNewFile *.tex set spell
au BufRead,BufNewFile *.txt set spell
au BufRead,BufNewFile *.md set spell

au BufRead,BufNewFile *.md set nofoldenable

"https://github.com/szymonmaszke/vimpyter
autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
autocmd Filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR>

"http://statico.github.io/vim.html
":nmap ; :CtrlP .<CR>
":nmap <C-o> :CtrlP .<CR>
"let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g' "https://github.com/junegunn/fzf/issues/337
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""' "https://github.com/junegunn/fzf/issues/337
:nmap <C-o> :FZF<CR>
:nmap <C-f> :Ag<CR>

"for DOS line endings
":nmap <C-m> :e ++ff=dos<CR>

"remove buttons in gvim
"http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text
:set guioptions-=T

"http://vim.wikia.com/wiki/Switch_between_Vim_window_splits_easily
noremap <C-Down> <C-W>j
noremap <C-Up> <C-W>k
noremap <C-Left> <C-W>h
noremap <C-Right> <C-W>l
inoremap <C-Down> <C-W>j
inoremap <C-Up> <C-W>k
inoremap <C-Left> <C-W>h
inoremap <C-Right> <C-W>l
noremap <C-tab> <C-w><C-w>
inoremap <C-tab> <C-o><C-w><C-w>
noremap ; <C-w>
noremap ;; <C-w><C-w>

" ========= below good ========= 

" ctags
command CT :!ctags --exclude=boost --recurse ./*
command CTP :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .

" try to make latex open a unique okular
" let g:Tex_ViewRule_pdf = 'okular --unique'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'qpdfview --unique'
" let g:Tex_ViewRule_pdf = 'qpdfview'
command Lualatex :let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode $*'

let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options
              \ = '--unique @pdf\#src:@tex:@line:@col'

" http://tex.stackexchange.com/questions/2941/how-to-setup-synctex-with-vim-pdflatex-and-an-open-source-pdf-viewer-under-linu
function! SyncTexForward()
    let pdffile = fnamemodify(glob("`find . -name *.latexmain -print`"), ":r:r").".pdf"
    let execstr = "!qpdfview --unique ".pdffile.'\#'."src:%:p:".line(".").":0 &"
    silent exec execstr
endfunction
nmap <Leader>f :call SyncTexForward()<CR>

" copy and paste
map <C-c> "+y
map <C-b> "+p
imap <C-v> <C-O>"+p

"http://www.vim.org/scripts/script.php?script_id=1709
au BufNewFile,BufRead SCons* set filetype=scons 

cabbrev scons set makeprg=scons

"http://pyclewn.sourceforge.net/_static/pyclewn.html
map \b :exe "Cbreak " . expand("%:p") . ":" . line(".")<CR>
map \p :exe "Cprint " . expand("<cword>") <CR>

"http://vim.wikia.com/wiki/Omni_completion_popup_menu
highlight Pmenu guibg=brown gui=bold

" http://amix.dk/blog/post/19021
" autocmd FileType python set omnifunc=pythoncomplete#Complete
" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType cpp set omnifunc=cppcomplete#CompleteCPP
autocmd FileType h set omnifunc=cppcomplete#CompleteCPP
" au BufNewFile,BufRead,BufEnter *.cpp,*.h set omnifunc=omni#cpp#complete#Main

" http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
map gh :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
map gc :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>

map <C-q> :q<CR>

noremap <F3> :ptjump <C-R><C-W><CR>
noremap <F4> <C-w><C-z>
inoremap <F3> <C-o>:ptjump <C-R><C-W><CR>
inoremap <F4> <C-o><C-w><C-z>

set incsearch

" remap caps lock when vim starts
" silent !setxkbmap -option caps:escape

au! BufRead,BufNewFile *.math setfiletype mma

"au BufNewFile,BufRead *.jl set filetype=julia 
"au BufNewFile,BufRead *.jl set foldmethod=syntax 

" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
 map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR> 

inoremap fd <Esc>
noremap fd <Esc>

syntax on

set wildignore+=*.so,*.swp,*.zip,*/data/*,.o,*/bin/*

let g:ctrlp_follow_symlinks=1
let g:ctrlp_show_hidden=1

" noremap <C-B> :e#<CR>
noremap <C-B> <C-o>

au BufRead,BufNewFile *.lcm set syntax=cpp

" https://bbs.archlinux.org/viewtopic.php?id=139163
hi Pmenu guibg=#202020 guifg=#BDB76B
hi PmenuSel guibg=#303030 guifg=#CD5C5C gui=bold
hi LineNr guifg=darkgrey
hi LineNr ctermfg=darkgrey

" http://stackoverflow.com/questions/3638542/any-way-to-delete-in-vim-without-overwriting-your-last-yank
nnoremap x "_x

set guioptions=Ace
set guifont=Monospace\ 11

" job specific settings
let hostname = substitute(system('hostname'), '\n', '', '')
if hostname == "sunberg0.mtv.corp.google.com"
    set expandtab tabstop=2 shiftwidth=2
    set textwidth=80
    set cc=+1
else
    set expandtab tabstop=4 shiftwidth=4
endif

" https://github.com/tpope/vim-surround/issues/47
" surround latex command
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

"let g:latex_to_unicode_auto = 1
"let g:latex_to_unicode_tab = 1

command -nargs=1 JLGrep :grep <args> src/*.jl

"http://stackoverflow.com/questions/2657641/remove-the-in-the-vim-latex
let g:Imap_UsePlaceHolders = 0

command Tab2 :set expandtab tabstop=2 shiftwidth=2

let g:auto_save_events = ["InsertLeave", "TextChanged", "CursorHoldI"]

" Enclose <args> in single quotes so it can be passed as a function argument.
com! -nargs=1 RemoteOpen :call RemoteOpen('<args>')
com! -nargs=? RemoteInsert :call RemoteInsert('<args>')

:let g:netrw_browsex_viewer="setsid xdg-open"

set complete=.,w,b,u,t

if has("unix")
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction
else
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction
endif


if has("gui_running")
    nmap <S-F12> :call FontSizeMinus()<CR>
    nmap <F12> :call FontSizePlus()<CR>
endif

" RemoteOpen: open a file remotely (if possible) {{{
" Description: checks all open vim windows to see if this file has been opened
"              anywhere and if so, opens it there instead of in this session.
function! RemoteOpen(arglist)

	" First construct line number and filename from argument. a:arglist is of
	" the form:
	"    +10 c:\path\to\file
	" or just
	" 	 c:\path\to\file
	if a:arglist =~ '^\s*+\d\+'
		let linenum = matchstr(a:arglist, '^\s*+\zs\d\+\ze')
		let filename = matchstr(a:arglist, '^\s*+\d\+\s*\zs.*\ze')
	else
		let linenum = 1
		let filename = matchstr(a:arglist, '^\s*\zs.*\ze')
	endif
	let filename = escape(filename, ' ')
	if exists('*Tex_Debug')
		call Tex_Debug("linenum = ".linenum.', filename = '.filename, "RemoteOpen")
	endif

	" If there is no clientserver functionality, then just open in the present
	" session and return
	if !has('clientserver')
		if exists('*Tex_Debug')
			call Tex_Debug("-clientserver, opening locally and returning", "RemoteOpen")
		endif
		exec "e ".filename
		exec linenum
		normal! zv
		return
	endif

	" Otherwise, loop through all available servers
	let servers = split(serverlist(), '\n')
	let targetServer = ''

	for server in servers
		" Find out if there was any server which was used by remoteOpen before
		" this. If a new gvim session was ever started via remoteOpen, then
		" g:Remote_Server will be set.
		if remote_expr(server, 'exists("g:Remote_Server")')
			let targetServer = server
		endif

		" Ask each server if that file is being edited by them.
		let bufnum = remote_expr(server, "bufnr('".filename."')")
		" If it is...
		if bufnum != -1
			" ask the server to edit that file and come to the foreground.
			" set a variable g:Remote_Server to indicate that this server
			" session has at least one file opened via RemoteOpen
			let targetServer = server
			break
		end
	endfor

	" If there are no servers, open file locally.
	if targetServer == ''
		if exists('*Tex_Debug')
			call Tex_Debug("no open servers, opening locally", "RemoteOpen")
		endif
		exec "e ".filename
		exec linenum
		let g:Remote_Server = 1
		normal! zv
		return
	endif

	" If none of the servers have the file open, then open this file in the
	" first server. This has the advantage if yap tries to make vim open
	" multiple vims, then at least they will all be opened by the same gvim
	" server.
	call remote_send(targetServer, 
		\ "\<C-\>\<C-n>".
		\ ":let g:Remote_Server = 1\<CR>".
		\ ":drop ".filename."\<CR>".
		\ ":".linenum."\<CR>zv"
		\ )
	call remote_foreground(targetServer)
	" quit this vim session
	if v:servername != targetServer
		q
	endif
endfunction " }}}
" RemoteInsert: inserts a \cite'ation remotely (if possible) {{{
" Description:
function! RemoteInsert(...)

	let citation =  matchstr(argv(0), "\\[InsText('.cite{\\zs.\\{-}\\ze}');\\]")
	if citation == ""
		q
	endif

	" Otherwise, loop through all available servers
	let servers = split(serverlist(), '\n')
	let targetServer = v:servername

	for server in servers
		if remote_expr(server, 'exists("g:Remote_WaitingForCite")')
			call remote_send(server, citation . "\<CR>")
			call remote_foreground(server)
			if v:servername != server
				q
			else
				return
			endif
		endif
	endfor

	q

endfunction " }}}

