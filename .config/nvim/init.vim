call plug#begin(stdpath('data').'/plugged')
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction
Plug 'ianks/vim-tsx', Cond(!exists('g:vscode'))
Plug 'leafgarland/typescript-vim', Cond(!exists('g:vscode'))
Plug 'tpope/vim-commentary', Cond(!exists('g:vscode'))
Plug 'dense-analysis/ale', Cond(!exists('g:vscode'))
let g:coc_node_path = $N_PREFIX . '/bin/node'
Plug 'neoclide/coc.nvim', Cond(!exists('g:vscode'), { 'branch': 'release' })
" coc extensions
let g:coc_global_extensions = [
\	'coc-pairs',
\	'coc-tsserver',
\	'coc-eslint',
\	'coc-json',
\]
Plug 'blankname/vim-fish', Cond(!exists('g:vscode'))
Plug 'junegunn/fzf.vim', Cond(!exists('g:vscode'))
if !exists('vscode')
  nnoremap <c-p> :FZF<cr>
endif
" -------------------------------------------------------------------------------------------------
" Themes
" -------------------------------------------------------------------------------------------------
" Plug 'morhetz/gruvbox', Cond(!exists('g:vscode'))
" Plug 'joshdick/onedark.vim', Cond(!exists('g:vscode'))
" Plug 'taniarascia/new-moon.vim', Cond(!exists('g:vscode'))
Plug 'tomasiser/vim-code-dark', Cond(!exists('g:vscode'))
Plug 'cormacrelf/vim-colors-github', Cond(!exists('g:vscode'))
" Plug 'kaicataldo/material.vim', Cond(!exists('g:vscode'))
" -------------------------------------------------------------------------------------------------
" Plug 'justinmk/vim-sneak'
" map f <Plug>Sneak_s
" map F <Plug>Sneak_S
" map f <Plug>Sneak_f
" map F <Plug>Sneak_F
" map t <Plug>Sneak_t
" map T <Plug>Sneak_T
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vim-easymotion-fork' })
Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
let g:XkbSwitchEnabled = 1
let g:XkbSwitchSkipGhKeys = ['gh', 'gH']
let g:XkbSwitchLib = '/usr/local/lib/libg3kbswitch.so'
Plug 'lyokha/vim-xkbswitch'
Plug 'justinmk/vim-sneak'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-surround'
let g:camelcasemotion_key = '<leader>'

" CamelCaseMotion mappings

" " Map to w, b and e mappings
" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
" map <silent> ge <Plug>CamelCaseMotion_ge
" sunmap w
" sunmap b
" sunmap e
" sunmap ge

" " Map iw, ib and ie motion 
" omap <silent> iw <Plug>CamelCaseMotion_iw
" xmap <silent> iw <Plug>CamelCaseMotion_iw
" omap <silent> ib <Plug>CamelCaseMotion_ib
" xmap <silent> ib <Plug>CamelCaseMotion_ib
" omap <silent> ie <Plug>CamelCaseMotion_ie
" xmap <silent> ie <Plug>CamelCaseMotion_ie

" " Map insert mode motions
" imap <silent> <S-Left> <C-o><Plug>CamelCaseMotion_b
" imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_w

Plug 'bkad/CamelCaseMotion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-repeat'
Plug 'nelstrom/vim-visual-star-search'
Plug 'haya14busa/is.vim'
" Plug 'tpope/vim-sleuth'
call plug#end()
let mapleader = "\<Space>"
nnoremap <SPACE> <Nop>
" map <Leader> <Plug>(easymotion-prefix)
filetype plugin indent on
filetype plugin on
syntax on
set title
set tabstop=2
set expandtab
set softtabstop=0
set shiftwidth=0

autocmd Filetype fish setlocal tabstop=4 softtabstop=0 shiftwidth=0 expandtab textwidth=79
autocmd Filetype fish compiler fish
autocmd Filetype lua setlocal tabstop=4 softtabstop=0 shiftwidth=0 expandtab textwidth=79

set autoindent
set smartindent
set encoding=utf-8
set pastetoggle=<F2>
set clipboard=unnamedplus
noremap x "_x
noremap X "_X
noremap <Del> "_x

" Alt-j/k deletes blank line below/above, and Ctrl-j/k inserts.
" nnoremap <silent><A-j> m`:silent +g/\m^\s*$/d _<CR>``:noh<CR>
" nnoremap <silent><A-k> m`:silent -g/\m^\s*$/d _<CR>``:noh<CR>
" nnoremap <silent><C-j> :set paste<CR>o<Esc>:set nopaste<CR>
" nnoremap <silent><C-k> :set paste<CR>O<Esc>:set nopaste<CR>
" nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>j
" nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>k

if exists('g:vscode')
	xmap gc  <Plug>VSCodeCommentary
	nmap gc  <Plug>VSCodeCommentary
	omap gc  <Plug>VSCodeCommentary
	nmap gcc <Plug>VSCodeCommentaryLine
endif
if !exists('g:vscode')
  " set spelllang=en_us,ru
  " set spell
	set background=dark
	" let g:gruvbox_contrast_dark = 'medium'
	" let g:gruvbox_contrast_light = 'medium'
	" let g:gruvbox_italic=1
	" let g:gruvbox_italicize_comments=1
	" let g:onedark_termcolors = 256
	" let g:onedark_terminal_italics = 1
	" 24 bit color support
	if (has("termguicolors"))
	  set termguicolors
	endif
  " let g:material_terminal_italics = 1
  " let g:material_theme_style = 'ocean'
  " let g:github_colors_soft = 1
	colorscheme codedark
  " highlight Normal ctermbg=NONE guibg=NONE
  " highlight LineNr ctermbg=NONE guibg=NONE
  " highlight NonText ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
	set number relativenumber
endif
" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
if !exists('g:vscode')
	nnoremap <Leader>r :%s///g<Left><Left>
	nnoremap <Leader>rc :%s///gc<Left><Left><Left>
else
	nnoremap <Leader>r :%s///g
	nnoremap <Leader>rc :%s///gc
endif

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
if !exists('g:vscode')
	xnoremap <Leader>r :s///g<Left><Left>
	xnoremap <Leader>rc :s///gc<Left><Left><Left>
else
	xnoremap <Leader>r :s///g
	xnoremap <Leader>rc :s///gc
endif
" set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" set keymap=russian-jcukenwin
" set iminsert=0
" set imsearch=0

if !exists('g:vscode')
	" Enable autocompletion:
	set wildmode=longest,list,full
	" -------------------------------------------------------------------------------------------------
	" coc.nvim default settings
	" -------------------------------------------------------------------------------------------------

	" if hidden is not set, TextEdit might fail.
	set hidden
	" Better display for messages
	set cmdheight=2
	" Smaller updatetime for CursorHold & CursorHoldI
	set updatetime=300
	" don't give |ins-completion-menu| messages.
	set shortmess+=c
	" always show signcolumns
	set signcolumn=yes
	" enable mouse support
	set mouse=a

	" Use tab for trigger completion with characters ahead and navigate.
	" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
	inoremap <silent><expr> <TAB>
		  \ pumvisible() ? "\<C-n>" :
		  \ <SID>check_back_space() ? "\<TAB>" :
		  \ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()

	" Use `[c` and `]c` to navigate diagnostics
	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)

	" Remap keys for gotos
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use U to show documentation in preview window
	" nnoremap <silent> U :call <SID>show_documentation()<CR>

	" Remap for rename current word
	nmap <leader>rn <Plug>(coc-rename)

	" Remap for format selected region
	vmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)
	" Show all diagnostics
	" nnoremap <silent> ,a  :<C-u>CocList diagnostics<cr>
	" Manage extensions
	" nnoremap <silent> ,e  :<C-u>CocList extensions<cr>
	" Show commands
	" nnoremap <silent> ,c  :<C-u>CocList commands<cr>
	" Find symbol of current document
	" nnoremap <silent> ,o  :<C-u>CocList outline<cr>
	" Search workspace symbols
	" nnoremap <silent> ,s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	" nnoremap <silent> ,j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	" nnoremap <silent> ,k  :<C-u>CocPrev<CR>
	" Resume latest coc list
	" nnoremap <silent> ,p  :<C-u>CocListResume<CR><Paste>

	" disable vim-go :GoDef short cut (gd)
	" this is handled by LanguageClient [LC]
	" let g:go_def_mapping_enabled = 0
	" == AUTOCMD ================================ 
	" by default .ts file are not identified as typescript and .tsx files are not
	" identified as typescript react file, so add following
	autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
	autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
	" == AUTOCMD END ================================
endif
