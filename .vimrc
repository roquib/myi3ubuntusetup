set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
"Dependencies of snipmate :)
"execute pathogen#infect()
filetype plugin indent on
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"
" Snippets for our use :)
Bundle 'garbas/vim-snipmate'
Bundle 'scrooloose/nerdtree'
" Dependency management
Bundle 'gmarik/vundle'
Bundle 'ervandew/supertab'
Bundle 'epeli/slimux'
Bundle 'endel/vim-github-colorscheme'
set number
set tabstop=4
set textwidth=79
set expandtab
set autoindent
set shiftwidth=4
set softtabstop=4
set nowritebackup
set showmatch
let python_highlight_all=1
syntax on
" Removing escape
ino jj <esc>
cno jj <c-c>
vno v <esc>
"execute instuction
map <F7> :w<CR>:!python %<CR>
map <F8> :w<CR>:!ruby %<CR>
syntax enable
set t_Co=256
set  rtp+=/home/abdur/.local/lib/python3.6/site-packages/powerline/bindings/vim/
set laststatus=2
" My leader key
let mapleader=","
" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
"Remvove highlight with leader + enter
map <Leader>e :w<CR>:!python3 %<CR>
map <Leader>r :w<CR>:!go run %<CR>
nmap <Leader><CR> :nohlsearch<cr>
map <leader>q :NERDTreeToggle<CR>
" Buffer switching
map <Leader>p :bp<CR> " ,p previous buffer
"map <Leader>c :colorscheme LightTwist<CR>
"map <Leader>f :colorscheme pychimp<CR>
map <Leader>t :colorscheme default<CR>
"map <Leader>m :colorscheme molokai<CR>
map <Leader>n :bn<CR> " ,n next buffer
map <Leader>d :bd<CR> " ,d delete buffer
map <Leader>s :SlimuxREPLSendLine<CR>
vmap <Leader>s :SlimuxREPLSendSelection<CR>
map <Leader>b :SlimuxREPLSendBuffer<CR>
map <Leader>a :SlimuxShellLast<CR>
map <Leader>w :w<CR>
colorscheme roquib
"colorscheme github
"colorscheme LightTwist
"colorscheme pychimp
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>
map <Leader>= :vertical resize +14<CR>
map <Leader>- :vertical resize -14<CR>
"map <Leader>z :w <CR> :!gcc % -o %< && ./%< <CR>
map <Leader>b :w <CR> :!javac % && java -cp %:p:h %:t:r <CR>
map <Leader>z :w <CR> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    if &filetype == 'c'
        exec "!gcc % -o %< && ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %< && ./%<"
    elseif &filetype == 'java'
        exec "!javac % && java -cp %:p:h %:t:r"
    elseif &filetype == 'sh'
        exec "!time bash %"
    endif
endfunc

