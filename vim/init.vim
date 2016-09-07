" set encoding=utf-8

syntax on
colorscheme molokai
set t_Co=256

set smarttab
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set pumheight=10

set showmatch
set matchtime=1

" general remap
" yank to the line-end
nnoremap Y y$
" increment number
nnoremap + <C-a>
" decriment number
nnoremap - <C-x>
" tabpage next 
nnoremap <C-s>n :tabnext<CR>
" tabpage previous
nnoremap <C-s>p :tabprevious<CR>
" disable Q (ex mode)
nnoremap Q <Nop>

call plug#begin('~/.config/nvim/plugged')
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/fzf', { 'dir': '~/.zplug/repos/junegunn/fzf', 'do': './install --all' }
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/unite.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nathanaelkane/vim-indent-guides'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
Plug 'cespare/vim-toml'
call plug#end()

" neosnippet
imap <C-k>	<Plug>(neosnippet_expand_or_jump)
smap <C-k>	<Plug>(neosnippet_expand_or_jump)
xmap <C-k>	<Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" for conceal markers
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

" for golang snippets
let g:neosnippet#snippets_directory='~/.config/nvim/plugged/vim-go/gosnippets/snippets/'

" deoplete settings
let g:python3_host_prog = '/usr/local/bin/python3'
let g:deoplete#enable_at_startup = 1

" Unite
let g:unite_enable_start_insert=1
nnoremap [unite]	<Nop>
nmap ,u [unite]
nnoremap <silent> [unite]u :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>

" lightline config
let g:lightline = {
	\ 'colortheme': 'wombat',
	\ 'active': {
	\	'left': [ [ 'mode', 'paste' ],
	\		      [ 'fugitive', 'filename' ] ]
	\ },
	\ 'component_function': {
	\	'readonly': 'LightLineReadonly',
	\   'modified': 'LightLineModified',
	\	'fugitive': 'LightLineFugitive',
	\   'filename': 'LightLineFilename',
	\ },
	\ }

let g:lightline.tabline = {
	\ 'left': [ [ 'tabs' ] ],
	\ 'right': [ [ 'close' ] ] }

function! LightLineModified()
	if &filetype == "help"
		return ""
	elseif &modified
		return "+"
	elseif &modifiable
		return ""
	else
		return ""
	endif
endfunction

function! LightLineReadonly()
	if &filetype == "help"
		return ""
	elseif &readonly
		return "⭤"
	else
		return ""
	endif
endfunction

function! LightLineFugitive()
	if exists("*fugitive#head")
		let branch = fugitive#head()
		return branch !=# '' ? '⭠ '.branch : ''
	endif
	return ''
endfunction

function! LightLineFilename()
	return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
		 \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
		 \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction
