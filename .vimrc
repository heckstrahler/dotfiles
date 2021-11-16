set clipboard+=unnamedplus
set mouse=a
set number

call plug#begin('~/.local/share/nvim/plugged')
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug g:plug_home.'/vim-jml'
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'lervag/vimtex'
Plug 'FredKSchott/CoVim'
call plug#end()

" Enable folding with the spacebar
nnoremap <space> za

set encoding=UTF-8

" spell checking
setlocal spell spelllang=de_de,en_us


"DEOPLETE
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"AIRLINE
let g:airline_powerline_fonts = 1

"GRUVBOX
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
set termguicolors



"2 spaces instead of tab 
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=0
set smarttab


" ------------------------------------------------
"               VIMTEX
" ------------------------------------------------

" use neovim-remote to search stuff in the pdf viewer
let g:vimtex_compiler_progname = 'nvr'

" leader required to use the texvim mappings
let maplocalleader = "."
"

" enable deoplete completion
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

" enable the vimtex folds
let g:vimtex_fold_enabled = 1

" Compile Latex with F5
:inoremap <F5> <C-\><C-N>:VimtexCompile<CR> 
:nnoremap <F5> :VimtexCompile<CR>


" Delete auxiliary files when you quit vim
augroup vimtex_config
  au!
  au User VimtexEventQuit call vimtex#compiler#clean(0)
  au User VimtexEventQuit call delete(expand('%:r') . '.synctex.gz')
augroup END


let g:vimtex_view_method = 'mupdf'

  " Close viewers on quit
  function! CloseViewers()
    if executable('xdotool') && exists('b:vimtex')
        \ && exists('b:vimtex.viewer') && b:vimtex.viewer.xwin_id > 0
      call system('xdotool windowclose '. b:vimtex.viewer.xwin_id)
    endif
  endfunction

  augroup vimtex_event_2
    au!
    au User VimtexEventQuit call CloseViewers()
  augroup END
