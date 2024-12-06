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
set laststatus=2
set autoindent
set wrap
set wildmenu
set showcmd
set noshowmode
set cursorline
set nobackup

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
map  <F8>  :w<CR>:call Compile()<CR>
imap  <F8>  <ESC>:w<CR>:call Compile()<CR>
map  <F9>  :w<CR>:call Run()<CR>
imap <F9>  <ESC>:w<CR>:call Run()<CR>
map  <F10> :w<CR>:call Debug()<CR>
imap <F10> <ESC>:w<CR>:call Debug()<CR>
nmap <leader>t :term<CR>
set noshowmode

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'luochen1990/rainbow'
Plug 'uiiaoo/java-syntax.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'Raimondi/delimitMate'
Plug 'Chiel92/vim-autoformat'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Yggdroot/LeaderF'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim'
Plug 'FittenTech/fittencode.vim'
call plug#end()

function! MyMode()
  let l:current_mode = mode()
  if l:current_mode ==# 'n'
    return 'NORMAL'
  elseif l:current_mode ==# 'i'
    return 'INSERT'
  elseif l:current_mode ==# 'v'
    return 'VISUAL'
  elseif l:current_mode ==# 'V'
    return 'VISUAL LINE'
  elseif l:current_mode ==# ''
    return 'VISUAL BLOCK'
  elseif l:current_mode ==# 'R'
    return 'REPLACE'
  elseif l:current_mode ==# 'c'
    return 'COMMAND'
  elseif l:current_mode ==# 't'
    return 'TERMINAL'
  else
    return 'UNKOWN'
  endif
endfunction

function! GitBranch()
  if system('git rev-parse --is-inside-work-tree') =~ 'true'
    let l:branch = system('git symbolic-ref --short HEAD 2> /dev/null')
    return '  ' . substitute(l:branch, '\n', '', 'g') . ' '
  endif
  return ''
endfunction

set statusline=%1*\ --%{MyMode()}--\ %*
set statusline+=%2*\%{GitBranch()}\%*
set statusline+=%3*\ %.50f%m%r%h%w\             "显示文件名和文件路径 (%<应该可以去掉)
set statusline+=%=%4*\%{&filetype}\ \|\ %*        "显示文件类型及文件状态
set statusline+=%5*\%{toupper(&fenc)}\ %*   "显示文件编码类型
set statusline+=%6*\ %{toupper(&ff)}\ %*
set statusline+=%7*\ row:%l/%L\ \col:%c\ %*   "显示光标所在行和列
set statusline+=%8*\ %p%%\ %*            "显示光标前文本所占总文本的比例
hi User1 cterm=none ctermfg=black ctermbg=green
hi User2 cterm=none ctermfg=black ctermbg=grey
hi User3 cterm=none ctermfg=white ctermbg=NONE
hi User4 cterm=none ctermfg=white ctermbg=NONE
hi User5 cterm=none ctermfg=white ctermbg=NONE
hi User6 cterm=none ctermfg=black ctermbg=yellow
hi User7 cterm=none ctermfg=black ctermbg=cyan
hi User8 cterm=none ctermfg=black ctermbg=white

if &term =~ "xterm"
    " INSERT mode
    let &t_SI = "\<Esc>[5 q" 
    " REPLACE mode
    let &t_SR = "\<Esc>[3 q" 
    " NORMAL mode
    let &t_EI = "\<Esc>[6 q" 
endif

" 插件配置
" Fittencode配置
let g:fitten_accept_key = "\<C-a>"

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
        \ 'Ignored'   : '☒',
        \ "Unknown"   : "?"
    \ }
let g:NERDTreeGitStatusUseNerdFonts = 1
"设置切换Buffer快捷键
nnoremap <Leader>] :bn<CR>
nnoremap <Leader>[ :bp<CR>
nnoremap <leader>cd :cd %:p<CR>

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

" 全局搜索插件配置
let g:Lf_ShortcutF='<C-p>'

" Git插件配置
let g:fugitive_statusline = 1
let g:fugitive_author_name = 'chiri'
let g:fugitive_author_email = 'shenyichen0103@ruc.edu.cn'
nnoremap <leader>ga :Git add<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>

" Java高亮增强配置
highlight link JavaIdentifier None
highlight TabLine ctermfg=none   ctermbg=none   cterm=none
highlight TabLineFill ctermfg=white  ctermbg=none   cterm=none
highlight TabLineSel  ctermfg=black   ctermbg=white   cterm=none
highlight LineNr  ctermfg=grey ctermbg=none
highlight TabLineLabel ctermbg=grey ctermfg=black cterm=none
highlight CursorLineNr ctermfg=Yellow cterm=bold
set showtabline=2  " 始终显示 tabline
set tabline=%!MyTabLine()

function! MyTabLine()
  let s = '%#TabLineLabel# Buffers >> %#TabLine#'  " 使用高亮组

  for i in range(1, bufnr('$'))
    if bufexists(i)
      " 获取 buffer 名称
      let bufname = bufname(i) == '' ? '[No Name]' : bufname(i)
      let icon = WebDevIconsGetFileTypeSymbol(bufname)

      " 如果是当前 buffer，则高亮显示
      if bufnr('%') == i
          let s .= ' %#TabLineSel# ' . i . ': ' . icon . ' ' . fnamemodify(bufname, ':t') . ' %#TabLine# '
      else
        let s .= ' ' . i . ': ' . icon . ' ' . fnamemodify(bufname, ':t') . ' '
      endif
      if i != bufnr('$')
          let s .= '|'
      endif
    endif
  endfor
  return s
endfunction

let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_statusline = 1
let g:NERDTreeShowlineNumber=1
let g:NERDTreeHidden=0
let g:webdevicons_conceal_nerdtree_brackets = 1
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:Turquoise = "40E0D0"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = "FE405F"
let s:git_orange = "F54D27"
let s:gray = "808A87"
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['o'] = s:gray " sets the color of o files to blue
let g:NERDTreeExtensionHighlightColor['py'] = s:orange " sets the color of o files to blue
let g:NERDTreeExtensionHighlightColor['md'] = s:purple " sets the color of o files to blue
let g:NERDTreeExtensionHighlightColor['h'] = s:green " sets the color of h files to blue
let g:NERDTreeExtensionHighlightColor['c'] = s:blue " sets the color of c files to blue
let g:NERDTreeExtensionHighlightColor['cpp'] = s:blue " sets the color of cpp files to blue
let g:NERDTreeExtensionHighlightColor['c++'] = s:blue " sets the color of c++ files to blue

hi comment ctermfg=60 cterm=none

" coc代码补全
set nowritebackup
set updatetime=300
" set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-@> coc#refresh()

hi CocFloating ctermfg=white   ctermbg=black
hi Normal ctermbg=none
