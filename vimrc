set nocompatible
set makeprg=/usr/local/Cellar/make/4.2.1/bin/gmake
set rtp+=/usr/local/opt/fzf
set pyxversion=3
set encoding=utf-8

set runtimepath^=$PROJECT_HOME/vim-erlang-omnicomplete
set runtimepath^=$PROJECT_HOME/vim-erlang-compiler
set runtimepath^=$PROJECT_HOME/vim-erlang-tags

syntax enable
colorscheme solarized
filetype plugin indent on

set ruler
set number
set visualbell t_vb= "

" Search
set hlsearch
set incsearch
" Mute highlighting
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" No backup
set nobackup
set nowb
set noswapfile

" Show trailing whitespace
set list

let g:deoplete#enable_at_startup = 0

" But only interesting whitespace
 if &listchars ==# 'eol:$'
   set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
   endif

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
set foldmethod=marker

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2
" Convenience mappings
nnoremap ZZ :wqa<CR>
nnoremap GG Go
" Use ctrl-[hjkl] to select the active split
" nnoremap <silent> <c-k> :wincmd k<CR>
" nnoremap <silent> <c-j> :wincmd j<CR>
" nnoremap <silent> <c-h> :wincmd h<CR>
" nnoremap <silent> <c-l> :wincmd l<CR>

" Sudo write (<leader>W)
cmap w!! %!sudo tee >/dev/null %<CR>

" Remap :W to :w
cnoreabbrev W w

" Indent/unident block (<leader>]) (<leader>[)
nnoremap <leader>] >i{<CR>
nnoremap <leader>[ <i{<CR>

call plug#begin('~/.vim/plugged')

" Go
Plug 'fatih/vim-go'

" Status bar
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'

" Git
Plug  'https://github.com/tpope/vim-fugitive.git'

" Snippets
Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Deoplete
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" Terraform
Plug 'https://github.com/hashivim/vim-terraform.git'

" Nomad
Plug 'https://github.com/hashivim/vim-nomadproject.git'

" Toml
Plug 'https://github.com/cespare/vim-toml'

" Python
Plug 'https://github.com/tell-k/vim-autopep8.git'

" fzf
Plug '/usr/loca/opt/fzf'
Plug 'junegunn/fzf.vim'

" Idris
Plug 'https://github.com/idris-hackers/idris-vim.git'
"
" Surround
Plug 'https://github.com/tpope/vim-surround.git'

" Ansible
Plug 'https://github.com/pearofducks/ansible-vim.git'

" File system
Plug 'https://github.com/scrooloose/nerdtree.git'

" Unimpaired
Plug 'https://github.com/tpope/vim-unimpaired.git'

" Repeat
Plug 'https://github.com/tpope/vim-repeat'

" Dockerfile
Plug 'https://github.com/ekalinin/Dockerfile.vim.git'

call plug#end()

let g:fzf_command_prefix = 'Fzf'

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

let g:autopep8_ignore="E501,W293"
let g:autopep8_select="E501,W293"
let g:autopep8_max_line_length=79

" SuperTab like snippets behavior.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

silent! nmap <C-p> :NERDTreeToggle<CR>
silent! nnoremap <leader>f :TerraformFmt<CR>

" Use powerline fonts for airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1
let g:airline_symbols.space = "\ua0"

" Strip trailing whitespace (<leader>ss)
function! StripWhitespace ()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace ()<CR>

" Enable repeat.vim on existing maps
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" Source the vimrc file after saving it
augroup sourcing
  autocmd!
  autocmd bufwritepost .vimrc source $MYVIMRC
augroup END

" Autoformat terraform files on save
augroup terraformat
  autocmd!
  autocmd bufwritepre *.tf,*.tfvars :TerraformFmt
augroup END

" Turn on ruby syntax highlighting for Vagrantfile
augroup vagrantfile
  autocmd!
  autocmd BufRead Vagrantfile set filetype=ruby
augroup END

" Turn on groovy syntax highlighting for Jenkinsfile
augroup jenkinsfile
  autocmd!
  autocmd BufRead Jenkinsfile.* set filetype=groovy | set shiftwidth=4 | set tabstop=4
augroup END

augroup qsql
  autocmd!
  autocmd BufRead *.qsql set filetype=sql
augroup END

" Fix path issues from vim.wikia.com/wiki/Set_working_directory_to_the_current_file
let s:default_path = escape(&path, '\ ') " store default value of 'path'
" Always add the current file's directory to the path and tags list if not
" already there. Add it to the beginning to speed up searches.
autocmd BufRead *
      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path-=".s:default_path |
      \ exec "set path^=".s:tempPath |
      \ exec "set path^=".s:default_path

" Changes to allow blank lines in blocks, and
" Top level blocks (zero indent) separated by two or more blank lines.
" Usage: source <thisfile> in pythonmode and
" Press: vai, vii to select outer/inner python blocks by indetation.
" Press: vii, yii, dii, cii to select/yank/delete/change an indented block.
onoremap <silent>ai :<C-u>call IndTxtObj(0)<CR>
onoremap <silent>ii :<C-u>call IndTxtObj(1)<CR>
vnoremap <silent>ai <Esc>:call IndTxtObj(0)<CR><Esc>gv
vnoremap <silent>ii <Esc>:call IndTxtObj(1)<CR><Esc>gv

function! IndTxtObj(inner)
  let curcol = col(".")
  let curline = line(".")
  let lastline = line("$")
  let i = indent(line("."))
  if getline(".") !~ "^\\s*$"
    let p = line(".") - 1
    let pp = line(".") - 2
    let nextblank = getline(p) =~ "^\\s*$"
    let nextnextblank = getline(pp) =~ "^\\s*$"
    while p > 0 && ((i == 0 && (!nextblank || (pp > 0 && !nextnextblank))) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      -
      let p = line(".") - 1
      let pp = line(".") - 2
      let nextblank = getline(p) =~ "^\\s*$"
      let nextnextblank = getline(pp) =~ "^\\s*$"
    endwhile
    normal! 0V
    call cursor(curline, curcol)
    let p = line(".") + 1
    let pp = line(".") + 2
    let nextblank = getline(p) =~ "^\\s*$"
    let nextnextblank = getline(pp) =~ "^\\s*$"
    while p <= lastline && ((i == 0 && (!nextblank || pp < lastline && !nextnextblank)) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      +
      let p = line(".") + 1
      let pp = line(".") + 2
      let nextblank = getline(p) =~ "^\\s*$"
      let nextnextblank = getline(pp) =~ "^\\s*$"
    endwhile
    normal! $
  endif
endfunction
