filetype plugin indent on " If installed using git
set rtp+=~/.fzf

" Load plugins
call plug#begin('~/.local/share/nvim/plugged')


" -=====[ Polyglot ]======-

let g:polyglot_disabled = ['clojure', 'latex', 'vimtex']


" -=====[ Plugins ]======-

Plug 'Raimondi/delimitMate'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'mhinz/vim-signify'
Plug 'airblade/vim-rooter'
Plug 'bling/vim-airline'        " status bar
Plug 'chriskempson/base16-vim' " better colors
Plug 'christoomey/vim-system-copy' " xclip texts
Plug 'edkolev/tmuxline.vim'
Plug 'itspriddle/vim-stripper'
Plug 'junegunn/vim-easy-align' " tabular alignment
Plug 'kien/rainbow_parentheses.vim' " colorful parentheses - the only possible way to see beauty at clojure
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'schickling/vim-bufonly'   " delete all buffers but current one
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary' " better comments
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline-themes'
Plug 'wakatime/vim-wakatime'
Plug 'tmhedberg/SimpylFold'

" Languages

Plug 'sheerun/vim-polyglot'
Plug 'uiiaoo/java-syntax.vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'mzlogin/vim-markdown-toc'

" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'hashivim/vim-terraform'

" " Clojure
Plug 'clojure-vim/async-clj-highlight', { 'for': 'clojure' }
" Plug 'clojure-vim/acid.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fireplace'
Plug 'clojure-vim/async-clj-omni'

" Python
Plug 'psf/black', { 'tag': '19.10b0' }
Plug 'vim-python/python-syntax'

" Node / JS
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Plug 'elzr/vim-json'
" Plug 'leafgarland/typescript-vim'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'mxw/vim-jsx'
" Plug 'pangloss/vim-javascript'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" HTML
Plug 'mattn/emmet-vim'

" Plugins become visible to Vim after this call
call plug#end()


" -======[ basics ]=====-

" My leader
let mapleader=","

syntax enable

set relativenumber
set ignorecase
set smartcase
set nohlsearch
set number

set autoindent 	 " Copy indent from current line when adding a new one
set backspace=2  " Delete everything with backspace
set expandtab 	 " Expand <tab> as spaces
set shiftwidth=2 " Columns indented using > > and < < or smart indent
set smartindent " Smart indent like a C-program
set smarttab              " Let < tab > and < bs > check shiftwidth or tabstop
set softtabstop=2         " Number of spaces to count while editing
set cursorline
set ruler
set number
set autowrite
set colorcolumn=80
set updatetime=500

set list                  " Show invisible characters
set listchars=""          " Reset the listchars
set listchars+=eol:¬      " Show end-of-line as "¬"
set listchars+=extends:>  " The character to show in the last column when wrap is
                          " off and the line continues beyond the right of the screen
set listchars+=precedes:< " The character to show in the last column when wrap is
                          " off and the line continues beyond the left of the screen
set listchars+=tab:\⇥\    " A tab should display as "⇥ ", trailing whitespace as "."
set listchars+=trail:.    " Show trailing spaces as dots
"
" tell vim to keep a backup
set backup " where to save backup files
set backupdir=$HOME/.vim/swp " where to save swp files
set dir=$HOME/.vim/swp " Trim empty lines on EOF before save


" -=====[ providers ]====-

let g:python3_host_prog = '/home/lucasmarqs/.asdf/shims/python3'
let g:python_host_prog  = '/home/lucasmarqs/.asdf/shims/python2'


" -=====[ colors and themes ] =====-

set termguicolors
" let base16colorspace=256
colorscheme base16-solarflare
" let g:airline_theme='base16_atelierforest'

" disable highlighting variables for Java files
highlight link JavaIdentifier NONE


" -=====[ Mapping commands ]=====-

" Tab navigations
nnoremap <tab> :tabnext<cr>
nnoremap <s-tab> :tabprevious<cr>
nnoremap <leader>n :tabnew<cr>
nnoremap <leader>w :tabclose<cr>

" NERDTree
nnoremap <leader>\ :NERDTreeToggle<cr>
nnoremap <leader>f\ :NERDTreeFind<cr>

" FZF
nnoremap <C-p> :FZF<cr>


" -=====[ Airline ]=====-

let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

function! TrimEndLines()
  let save_cursor=getpos(".")
  :silent! %s#\($\n\s*\)\+\%$##
  call setpos(".", save_cursor)
endfunction
autocmd BufWritePre <buffer> call TrimEndLines()

"
" -=====[ FZF ]=====-

let g:fzf_layout = { 'down': '~20%' }


" -=====[ Go configurations ]=====-

" Go syntax highlights
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" default go file tab indent
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" go fmt command on save
let g:go_fmt_command = "goimports"

" on `myFunc := func() {}` don't include `myFunc` on selector
let g:go_textobj_include_variable = 0

autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <Leader>s :GoSameIds<cr>
autocmd FileType go nmap <Leader>sc :GoSameIdsClear<cr>


" -=====[ Terraform configurations ]=====-

let g:terraform_align=1
let g:terraform_fmt_on_save=1
let g:terraform_remap_spacebar=1

" -=====[ Clojure ]======-

" " config clojure
" let g:clojure_maxlines = 0
" let g:clojure_align_multiline_strings = 1
" let g:clojure_align_subforms = 1

" Add some words which should be indented like defn etc: Compojure/compojure-api, midje and schema stuff mostly.
let g:clojure_fuzzy_indent_patterns=['^GET', '^POST', '^PUT', '^DELETE', '^ANY', '^HEAD', '^PATCH', '^OPTIONS', '^def']
autocmd FileType clojure setlocal lispwords+=describe,it,testing,facts,fact,provided

" " load clojure deps
" autocmd BufReadCmd,FileReadCmd,SourceCmd jar:file://* call s:LoadClojureContent(expand("<amatch>"))
"  function! s:LoadClojureContent(uri)
"   setfiletype clojure
"   let content = CocRequest('clojure-lsp', 'clojure/dependencyContents', {'uri': a:uri})
"   call setline(1, split(content, "\n"))
"   setl nomodified
"   setl readonly
" endfunction


" -=====[ COC configurations ]=====-

" let g:coc_node_path = '/home/lucasmarqs/.asdf/shims/node'

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" open definition on a new tab
nmap <silent> <C-W>gd :call CocActionAsync('jumpDefinition', 'tab drop')<CR>
nmap <silent> <leader>vs :call CocActionAsync('jumpDefinition', 'vsplit')<CR>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" -=====[ Dipatch ]=====-


" -=====[ Easy align ]=====-

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" -=====[ Rainbow ]=====-
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax clojure RainbowParenthesesLoadRound
au Syntax clojure RainbowParenthesesLoadSquare
au Syntax clojure RainbowParenthesesLoadBraces

" -=====[ custom fn ]=====-

function PrettyJson()
  %!python -m json.tool
endfunction

" === search the entire project ===
map <leader>* :Ggrep --untracked <cword><CR><CR>
