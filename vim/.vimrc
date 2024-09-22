" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Turn mouse on
set mouse=a

" Editor Settings "
set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set showcmd
set showmode
set showmatch
set history=1000
set clipboard=unnamedplus

" Search Settings "
set incsearch
set hlsearch

" Backup Setting "
set nobackup nowritebackup

let mapleader = " "
nnoremap <leader>pv :Ex<CR>


" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Search down into subfolders
" Provides tab-completion for all file-realated tasks
set path+=**

command! MakeTags !ctags -R .


noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

let g:netrw_banner=0        " Disable annoying banner
" let g:netrw_browse_split=4  " Open in prior window
" let g:netrw_altv=1          " Open splits to the right
let g:netrw_liststyle=3     " Tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
