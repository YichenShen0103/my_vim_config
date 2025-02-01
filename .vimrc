let mapleader=' '
set nu
set relativenumber
set hlsearch
set incsearch
set ignorecase
set smartcase
set clipboard=unnamed
set encoding=utf-8
syntax on
language C
set nocompatible
filetype on
filetype indent on
filetype plugin on
let &t_ut=''
set expandtab
set mouse=a
set tabstop=4
set shiftwidth=4
set softtabstop=4
set listchars=tab:>~
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
set laststatus=0
set autoindent
set wrap
set wildmenu
set showcmd
set cursorline

inoremap jj <Esc>
inoremap jk <Esc>
inoremap kk <Esc>
vnoremap v <Esc>
nnoremap H ^
nnoremap L $
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :wq<CR>
nnoremap <Leader>Q :q!<CR>
nnoremap U <C-r>
nnoremap <Leader>d  <C-d>
nnoremap <Leader>u  <C-u>
nnoremap <Leader>sc :nohlsearch<CR>
nnoremap <Leader>v ggvG
nnoremap <Leader>rl :source $MYVIMRC<CR>
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>
map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l
map sv <C-w>t<c-W>H
map sv <C-w>t<c-W>K
map tu :tabe<CR>
map tc :tabc<CR>
map tp :-tabnext<CR>
map tn :+tabnext<CR>
map tmn :-tabmove<CR>
map tmi :+tabmove<CR>
nmap <leader>t :term<CR>

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
" Plug 'github/copilot.vim'
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'Raimondi/delimitMate'
Plug 'neoclide/coc.nvim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Yggdroot/LeaderF'
Plug 'easymotion/vim-easymotion'
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

" NerdTree配置
map <leader>p :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGitStatusIndicatorMapCustom = {
        \ "Modified"  : "~",
        \ "Staged"    : "+",
        \ "Untracked" : "!",
        \ "Renamed"   : ":",
        \ "Unmerged"  : "=",
        \ "Deleted"   : "×",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔",
        \'Ignored'    : '☒',
        \ "Unknown"   : "?"
        \}
let g:NERDTreeGitStatusUseNerdFonts = 1

" Rainbow配置
let g:rainbow_conf = {
\   'guifgs': ['yellow','violet','lightgreen','darkcyan'],
\   'ctermfgs': ['yellow', 99, 'blue'],
\   'operators': '_,\|+\|-_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'css': 0,
\   }
\}
let g:rainbow_active = 1

" CPP代码高亮优化
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

highlight LineNr  ctermfg=grey ctermbg=none
highlight CursorLineNr ctermfg=Yellow cterm=bold

" 代码补全配置
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
      let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
endfunction

hi CocFloating ctermfg=white   ctermbg=black

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 检测 ~/.cache/tags 不存在就新建 
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']


