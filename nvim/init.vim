" Load vim-plug
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
    execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'kien/ctrlp.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'airblade/vim-gitgutter'

Plug 'vimwiki/vimwiki'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()


"== general settings
" Map the leader key to SPACE
let mapleader="\<SPACE>"
let maplocalleader="\<SPACE>"

scriptencoding utf-8
set encoding=utf-8
set fenc=utf-8
set termencoding=utf-8

set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.
set cursorline          " Highlight current line
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

set backspace=eol,start,indent

set clipboard=unnamed   " Yank/Paste to system clipboard

if !&scrolloff
	set scrolloff=3       	" Show next 3 lines while scrolling.
endif

if !&sidescrolloff
	set sidescrolloff=5 	" Show next 5 columns while side-scrolling.
endif
set nostartofline		" Do not jump to first character with page commands.

colorscheme elflord

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
    set listchars=tab:>\,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

" buffer moving settings
set hidden
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprev<CR>
nnoremap <S-k> :bdelete<CR>

"Folding
map <F2> v]}zf
map <F3> zo
map <F4> zd

nmap <F8> :NERDTreeToggle .<CR>

" Escape input mode in terminal
tnoremap <ESC> <C-\><C-n>

"== vim-airline
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'
let g:airline_theme= 'bubblegum'

"== NERDTree
let NERDTreeIgnore=['\.vim$','\~$','*.o','tags','*.out','cscope']
"let NERDTreeQuitOnOpen=1
let NERDTreeWinPos="left"

"== vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"== ctrlp
let g:ctrlp_map = '<c-p>'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore += '\v\.(exe|so|dll)$'

"== Deoplete.
let g:deoplete#enable_at_startup = 1

"== vim-clang
let g:clang_c_options='-std=gnu11'
let g:clang_cpp_options='-std=c++11 -stdlib=libc++'

"== gtags
let g:Gtags_Auto_Update=1
nmap <C-]> :Gtags<CR><CR>
nmap <C-\> :Gtags -r<CR><CR>
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>

"== vim-wiki
let wiki = {}
let wiki.path = '~/workspace/raymondk/kangic.github.io/_wiki/'
let wiki.ext = '.md'

let g:vimwiki_list = [wiki]
let g:vimwiki_conceallevel = 0

function! LastModified()
    if &modified
        let save_cursor = getpos(".")
        let n = min([10, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}updated\s*: \).*#\1' .
              \ strftime('%Y-%m-%d %H:%M:%S +0900') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfun
autocmd BufWritePre *.md call LastModified()
