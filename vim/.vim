set encoding=utf-8

syntax on
colorscheme molokai
set t_Co=256

set tabstop=4
set smarttab
set shiftwidth=4
set smartindent
set autoindent

call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.zplug/repos/junegunn/fzf', 'do': './install --all' }
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/unite.vim'
Plug 'nathanaelkane/vim-indent-guides'
call plug#end()

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
	\ },
	\ }

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
