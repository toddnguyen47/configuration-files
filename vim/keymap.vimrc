" IdeaVIM only
nnoremap <Space> <NOP>

" Visual shortcuts
let mapleader = " "

" Visual mode: Yank to clipboard
vnoremap <leader>y "+y

" Visual and normal mode: Paste from clipboard
vnoremap <leader>p "+p
nnoremap <leader>p "+p

" Normal mode: yank line to clipboard
nnoremap <leader>yy "+yy

" Paste from register 'a' with <leader>a
" Reference: https://www.reddit.com/r/vim/comments/101u4kf/comment/j2r7zpn/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
nnoremap <leader>0 "0p
vnoremap <leader>0 "0p
