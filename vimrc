set number 
set nowrap 
set tabstop=4
set showcmd
set foldcolumn=1

" Swap 1s for 2s on a given line 
command! OT .s/1/2/g 
command! COLM %!column -t
"command! LATEX <silent> %!pdflatex initial_candidature_review.tex && bibtex initial_candidature_review.aux && pdflatex initial_candidature_review.tex && pdflatex initial_candidature_review.tex > /dev/null 2>&1 <CR>

" Point to ctags file - for easy navigation in c++ 
set tags=./tags,tags;$HOME

" common sense remappings
:map <space> <leader>
:noremap : ;
:noremap ; :

" fuckin golden - shift-tab to escape from any mode
noremap <S-tab> <esc>
noremap! <S-tab> <esc>

"move current line down
nnoremap <leader>j jddkkpj
"move current line up
nnoremap <leader>k kddpk

" quickly add to and save vimrc
:nnoremap <leader>ev :split $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" abbreviations
iabbrev ssig -- <cr>Reinhold Willcox<cr>reinhold.willcox@monash.edu<cr><cr>
iabbrev @@ reinhold.willcox@monash.edu

" surround word in quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" set autocmds for filetype python, c++, vim, and html, where html gets a front and back one, and python and c++ have options for single and multiline
autocmd FileType vim,vimrc nnoremap <buffer> <leader>cc ^i"<esc>
autocmd FileType python    nnoremap <buffer> <leader>cc ^i#<esc>
autocmd FileType c,c++     nnoremap <buffer> <leader>cc ^i//<esc>
autocmd FileType css       nnoremap <buffer> <leader>cc ^i/*<esc>A*/<esc>
autocmd FileType html      nnoremap <buffer> <leader>cc ^i<!--<space><esc>A<space>--><esc>
autocmd FileType tex       nnoremap <buffer> <leader>cc I%<esc>
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

" All latex-exclusive commands, i.e wrap
augroup latex
	autocmd!
	autocmd FileType latex,tex :setlocal wrap
augroup END

" fold in by open and close brackets in html
augroup html
	autocmd!
	autocmd FileType html nnoremap <buffer> <leader>f Vatzf
	setlocal tabstop=2
augroup END

" Save and load all fold data
augroup folds
	autocmd!
	" Fix this so that it saves on any write, and loads on any :e
	autocmd QuitPre * mkview
	autocmd BufRead * loadview
augroup END


" <nop> is the "turn off" key









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
