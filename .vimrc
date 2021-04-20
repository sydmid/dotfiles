" Close current buffer
map <leader>bd :Bclose<cr>

" Close all buffers
map <leader>ba :1,1000 bd!<cr>

" Fast Saving Buffer
nmap <leader>w :w!<cr>

map <space> /
map <C-space> ?
map <silent> <leader><cr> :noh<cr>

map <leader>pp :setlocal paste!<cr>

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" COMMAND LINE MAPPINGS
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

command W w !sudo tee "%" > /dev/null

vmap <Leader>y "+y
vmap <Leader>p "+p
