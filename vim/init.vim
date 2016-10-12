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
set backspace=indent,eol,start

set showmatch
set showcmd
set matchtime=1
set laststatus=2

set nobackup
set noswapfile
	
"--------------------------------------------------------------------------------
" general remap

" yank to an line-end
nnoremap Y y$
" increment number
nnoremap + <C-a>
" decriment number
nnoremap - <C-x>
" tabpage next 
nnoremap tn :tabnext<CR>
" tabpage previous
nnoremap tp :tabprevious<CR>
" disable Q (ex mode)
nnoremap Q <Nop>

"--------------------------------------------------------------------------------
" Vim-Plug settings

" checking function for vim-plug
let s:plug = {
			\ "plugs": get(g:, 'plugs', {})
			\ }

function! s:plug.is_installed(name)
	return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

" vim-plug init
call plug#begin('~/.vim/plugged')
Plug 'tomtom/tcomment_vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.zplug/repos/junegunn/fzf', 'do': './install --all' }
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'plasticboy/vim-markdown'
" Plug 'Shougo/unite.vim'
if has('lua') && !has('nvim')
	Plug 'Shougo/neocomplete.vim'
endif
if !has('lua') && !has('nvim')
	Plug 'Shougo/neocomplcache.vim'
endif
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
Plug 'othree/yajs.vim'
Plug 'cespare/vim-toml'
Plug 'thinca/vim-ref'
Plug 'udalov/kotlin-vim'
call plug#end()

"--------------------------------------------------------------------------------
" neocomplete settings

if has('lua') && !has('nvim')
	" let g:neocomplete#enable_at_startup = 1
	" let g:neocomplete#enable_ignore_case = 1
	" let g:neocomplete#enable_smart_case = 1
	" if !exists('g:neocomplete#keyword_patterns')
	" 	let g:neocomplete#keyword_patterns = {}
	" endif
	" let g:neocomplete#keyword_patterns._ = '\h\w*'
    "
	" if !exists('g:neocomplete#sources#dictionary#dictionaries')
	" 	let g:neocomplete#sources#dictionary#dictionaries = {}
	" endif
	" let dict = g:neocomplete#sources#dictionary#dictionaries
    "

	"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
	"" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplete.
	let g:neocomplete#enable_at_startup = 1
	" Use smartcase.
	let g:neocomplete#enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplete#sources#syntax#min_keyword_length = 3
	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

	" Define dictionary.
	let g:neocomplete#sources#dictionary#dictionaries = {
				\ 'default' : '',
				\ 'vimshell' : $HOME.'/.vimshell_hist',
				\ 'scheme' : $HOME.'/.gosh_completions'
				\ }

	" Define keyword.
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g> neocomplete#undo_completion()
	inoremap <expr><C-l> neocomplete#complete_common_string()

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
		return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
		" For no inserting <CR> key.
		"return pumvisible() ? "\<C-y>" : "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
	" Close popup by <Space>.
	"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

	" AutoComplPop like behavior.
	"let g:neocomplete#enable_auto_select = 1

	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplete#enable_auto_select = 1
	"let g:neocomplete#disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplete#sources#omni#input_patterns')
		let g:neocomplete#sources#omni#input_patterns = {}
	endif
	"let g:neocomplete#sources#omni#input_patterns.php = '[^.  \t]->\h\w*\|\h\w*::'
	"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

	" For perlomni.vim setting.
	" https://github.com/c9s/perlomni.vim
	let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

if !has('lua') && !has('nvim')
	"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	"Use neocomplcache.
	let g:neocomplcache_enable_at_startup = 1
	" Use smartcase.
	let g:neocomplcache_enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplcache_min_syntax_length = 3
	let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

	" Enable heavy features.
	" Use camel case completion.
	"let g:neocomplcache_enable_camel_case_completion = 1
	" Use underbar completion.
	"let g:neocomplcache_enable_underbar_completion = 1

	" Define dictionary.
	let g:neocomplcache_dictionary_filetype_lists = {
				\ 'default' : '',
				\ 'vimshell' : $HOME.'/.vimshell_hist',
				\ 'scheme' : $HOME.'/.gosh_completions'
				\ }

	" Define keyword.
	if !exists('g:neocomplcache_keyword_patterns')
		let g:neocomplcache_keyword_patterns = {}
	endif
	let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g> neocomplcache#undo_completion()
	inoremap <expr><C-l> neocomplcache#complete_common_string()

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
		return neocomplcache#smart_close_popup() . "\<CR>"
		" For no inserting <CR> key.
		"return pumvisible() ?
		neocomplcache#close_popup() : "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y> neocomplcache#close_popup()
	inoremap <expr><C-e> neocomplcache#cancel_popup()
	" Close popup by <Space>.
	"inoremap <expr><Space> pumvisible() ?
	neocomplcache#close_popup() : "\<Space>"

	" For cursor moving in insert mode(Not recommended)
	"inoremap <expr><Left>
	neocomplcache#close_popup() . "\<Left>"
	"inoremap <expr><Right>
	neocomplcache#close_popup() . "\<Right>"
	"inoremap <expr><Up>
	neocomplcache#close_popup() . "\<Up>"
	"inoremap <expr><Down>
	neocomplcache#close_popup() . "\<Down>"
	" Or set this.
	"let g:neocomplcache_enable_cursor_hold_i = 1
	" Or set this.
	"let g:neocomplcache_enable_insert_char_pre = 1

	" AutoComplPop like behavior.
	"let g:neocomplcache_enable_auto_select = 1

	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplcache_enable_auto_select = 1
	"let g:neocomplcache_disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ?  "\<Down>" : "\<C-x>\<C-u>"

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplcache_force_omni_patterns')
		let g:neocomplcache_force_omni_patterns = {}
	endif
	let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

	" For perlomni.vim setting.
	" https://github.com/c9s/perlomni.vim
	let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif

"-------------------------------------------------------------------------------
" neosnippet settings

imap <C-k>	<Plug>(neosnippet_expand_or_jump)
smap <C-k>	<Plug>(neosnippet_expand_or_jump)
xmap <C-k>	<Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Set conceal markers for neosnippet
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

" for golang snippets
" let g:neosnippet#snippets_directory='~/.config/nvim/plugged/vim-go/gosnippets/snippets/'

" snippets directory
let g:neosnippet#snippets_directory='~/.dotfiles/vim/snippets/'


"--------------------------------------------------------------------------------
" deoplete settings

if has('nvim')
	let g:python3_host_prog = '/usr/local/bin/python3'
	let g:deoplete#enable_at_startup = 1
endif

"--------------------------------------------------------------------------------
" Unite

" let g:unite_enable_start_insert=1
" nnoremap [unite]	<Nop>
" nmap ,u [unite]
" nnoremap <silent> [unite]u :<C-u>Unite file_mru buffer<CR>
" nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>

"--------------------------------------------------------------------------------
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

" php reference
let g:ref_phpmanual_path = $HOME . '/.vim/refs/php-chunked-xhtml'
