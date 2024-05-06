
let mapleader = ","

" new terminal
nmap <silent> <leader><space><space> :terminal<CR>
nmap <silent> <C-T>n :tab terminal<CR>

" edit and source config file
nmap <leader>vv :tabe ~/.vimrc<CR>
nmap <leader>sv :so ~/.vimrc<CR>

" clear selection
noremap <silent><Esc><Esc> :nohls<CR>

" enable or disable numbers
function! ToggleNumber()
	if (&number == 1)
		set nonumber
	else
		set number
	endif
endfunc
nmap <silent> <leader>n :call ToggleNumber()<CR>

" Navigate tabs with Ctrl+Arrow or Ctrl+G,Arrow
nnoremap <silent> <C-Left> gT
nnoremap <silent> <C-Right> gt
nnoremap <silent> <C-G><Left> gT
nnoremap <silent> <C-G><Right> gt

nnoremap <silent> <C-M-Up>   :m-2<CR>
nnoremap <silent> <C-M-Down> :m+1<CR>
vnoremap <C-M-Up>   :m '<-2<CR>gv=gv
vnoremap <C-M-Down> :m '>+1<CR>gv=gv

