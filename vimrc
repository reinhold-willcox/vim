" Caps lock was removed in place of Esc (single press) and Ctrl (press with another) using the command found here: http://tiborsimko.org/capslock-escape-control.html
" Additionally, Shift+Caps_Lock was set to Caps_Lock in ~/.Xmodmap (use `xmodmap ~/.Xmodmap' to source changes)	

" Specify plugin download directory
call plug#begin('/home/rwillcox/.vim/plugins')

" Delcare list of plugins
" See: https://dev.to/christalib/i-spent-3-years-configuring-n-vim-and-this-what-i-learnt-22on

"Iron.nvim does REPL
"Plug 'hkupty/iron.nvim'

"vimpyter integrates vim and jupyter notebooks
"Plug 'szymonmaszke/vimpyter'

"Run jupyter and vim simultaneously
"Plug 'jupyter-vim/jupyter-vim'

" Uncompromising Python code formatter
"Plug 'psf/black', { 'tag': '19.10b0' }

" Powerful linter and fixer 
"Plug 'dense-analysis/ale'

" Python autocompletion (with Vim)
Plug 'davidhalter/jedi-vim' 

" Completion tool, can also be made language specific
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" -- and if jedi is installed...
"Plug 'deoplete-plugins/deoplete-go'


" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Required:
filetype plugin indent on

" To add plugins, include the name in the list above,
" then run :PlugUpdate to add them
""""""""

set number 
set nowrap 
set expandtab
set tabstop=4
set shiftwidth=4
set showcmd
set foldcolumn=1

syntax on
colorscheme ron

" Swap 1s for 2s on a given line 
command! OT .s/1/2/g 
command! COLM %!column -t
" figure out how to expand the COLM command to selections. The following will work for selections   :'<,'>!column -t   just need to figure out how to incorporate that in...
"command! LATEX <silent> %!pdflatex initial_candidature_review.tex && bibtex initial_candidature_review.aux && pdflatex initial_candidature_review.tex && pdflatex initial_candidature_review.tex > /dev/null 2>&1 <CR>
" not ready yet... command! TTS %!tts

" Space out the COMPAS output files correctly, and skip any errors along the way
function! COMPAS()
	try
		%s/\s*//g 
	catch
		echo "Caught error: " . v:exception
	endtry

	try
		2s/^/#/g 
	catch
		echo "Caught error: " . v:exception
	endtry

	try
		2s/,,/,#,/g 
	catch
		echo "Caught error: " . v:exception
	endtry

	try
		2s/,,/,#,/g 
	catch
		echo "Caught error: " . v:exception
	endtry

	try
		%s/,/,\t/g 
	catch
		echo "Caught error: " . v:exception
	endtry

	COLM
	HEADER
endfunction
command! COMPAS call COMPAS()


" Point to ctags file - for easy navigation in c++ 
set tags=./tags,tags;$HOME

" common sense remappings
map <space> <leader>
noremap : ;
noremap ; :

"move current line down
nnoremap <leader>j jddkkpj
"move current line up
nnoremap <leader>k kddpk

" quickly add to and save vimrc
:nnoremap <leader>ev :split $VIMRC<cr>
:nnoremap <leader>sv :source $VIMRC<cr>

" abbreviations
iabbrev ssig -- <cr>Reinhold Willcox<cr>reinhold.willcox@monash.edu<cr><cr>
iabbrev @@ reinhold.willcox@monash.edu

" surround word in quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" make it easier to move around screens
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" NERDTree
map <F2> :NERDTreeToggle<CR>

" Jedi-Vim mods
"let g:jedi#completions_command = "<S-tab>"

" Folding - indent works best for python
"set foldmethod=indent
"set foldlevel=99
"nnoremap <leader><space> za

" Default to not read-only in vimdiff
set noreadonly

" set autocmds for filetype python, c++, vim, and html, where html gets a front and back one, and python and c++ have options for single and multiline
autocmd FileType vim,vimrc		nnoremap <buffer> <leader>cc ^i"<esc>
autocmd FileType python,bash,sh nnoremap <buffer> <leader>cc ^i#<esc>
autocmd FileType c,c++,cpp 		nnoremap <buffer> <leader>cc ^i//<esc>
autocmd FileType css   			nnoremap <buffer> <leader>cc ^i/*<esc>A*/<esc>
autocmd FileType html  			nnoremap <buffer> <leader>cc ^i<!--<space><esc>A<space>--><esc>
autocmd FileType tex   			nnoremap <buffer> <leader>cc I%<esc>
"Fix the html one...

" and for multiline comments
autocmd FileType python nnoremap <buffer> <leader>cb ^i"""<esc>
autocmd FileType python nnoremap <buffer> <leader>ce A"""<esc>
autocmd FileType c,c++,css nnoremap <buffer> <leader>cb ^i/*<esc>
autocmd FileType c,c++,css nnoremap <buffer> <leader>ce A*/<esc>
autocmd FileType html nnoremap <buffer> <leader>cb ^i<!-- <esc>
autocmd FileType html nnoremap <buffer> <leader>ce A --><esc>
autocmd FileType tex nnoremap <buffer> <leader>cb O\begin{comment}<esc>
autocmd FileType tex nnoremap <buffer> <leader>ce o\end{comment}<esc>

"set autocommands for common functions of different languages
"autocmd FileType python :iabbrev <buffer> iff if:o<tab>k$<left>
"autocmd FileType python :iabbrev <buffer> iff if:<cr><c-i>

autocmd FileType *.py
	\ set autoindent
	\ set fileformat=unix

" All latex-exclusive commands, i.e wrap
augroup latex
	autocmd!
	autocmd FileType latex,tex :setlocal wrap
augroup END

" fold in by open and close brackets in html
augroup html
	autocmd!
	autocmd FileType html nnoremap <buffer> <leader>f Vatzf
	autocmd FileType html setlocal tabstop=2
augroup END

" Save and load all fold data
"augroup folds
"	autocmd!
"	" Fix this so that it saves on any write, and loads on any :e
"	" This is vitally important!
"	autocmd QuitPre * mkview
"	autocmd BufRead * loadview
"augroup END

" Function to split a data file into a header and body, with correct scrollbinding
function! HEADER(...)
	" split screen, make upper screen N high, 4 by default
	try
		let buff = a:1
	catch
		let buff = 4
	endtry

	execute buff.'split'
	execute buff.'normal O'
	execute 'normal gg'

	" set scrollbinding for upper window
	set scb
	set sbo+=hor
	set sbo-=ver

	" switch to lower window
	wincmd j

	" set scrollbinding for lower window
	set scb
	set sbo+=hor
	set sbo-=ver

	" set top valid line to top of screen
	execute 'normal '.(buff+1).'z+'

endfunction
command! HEADER call HEADER()

" <nop> is the "turn off" key


" kite commands
"set laststatus=2 " always show the status line
"set statusline=%<%f\ %h%m%r%{kite#statusline()}%=%-14.(%l,%c%V%)\ %P
"let g:kite_tab_complete=1	
"set completeopt-=preview
""set completeopt+=preview

"Plugin 'davidhalter/jedi-vim'




" TODO: 
"find out how to make vim remember a visual selection
" purpose of this is to do some stuff around the visual selection, then capture it again afterward

"inoremap <c-shift> <esc>bveUeA 
" turns last word full caps in insert mode
" doesn't work if it's the last character in the file...
" can't use <c-i> it means the same thing as tab...

" add in OneNote like movement of lines (and tabs) using alt+shift+arrows
" want it to work on visually selected blocks (well, lines at least)
" and if possible, to have preceeding Ns work to repeat the whole command
" 	in insert mode, ctrl-t and ctrl-d move tabs left and right

" map caps lock to ctrl, and ctrl to caps lock I suppose?

" find a way to make visual mode U to uppercase my current word (alreday does the selection)

" Test vim S&R with the special characters from vimregex.com
" Especially
" \h head of word character
" \p printable character

" Setup a command for latex files only that compiles the current document. If it's been run (with xdg-open) already, the window will simply update. Maybe setup an if then, so that I can also open the doc if it hasn't already

" Setup a command that, whenever I quit a file, saves the current folds. Ostensibly, this should be :mkview, and then loaded with :loadview, but check the scope of these first

" Find the bashrc filetype and add in commenting to it

" Add in a quick command that will toggle True to False (and possibly other common booleans)

" Add in a command that will split screens and set scb on, horizontal only, with ~5 lines at the top, for data files with headers


