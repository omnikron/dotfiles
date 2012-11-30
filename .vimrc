" ====================================
" Oliver's .vimrc stuff
" ====================================
" Sets leader to comma instead of \
let mapleader=","

" Sets ctrl-l to make a hashrocket with quotes: => "|" 
imap <C-l> <Space>=><Space>"

" convert word into ruby symbol
imap <C-k> <C-o>b:<Esc>Ea
nmap <C-k> lbi:<Esc>E

" Press space in normal mode to enter a command
nnoremap <Space> :

" Open NERDTree to the current file LIKE MAGIC
:command NF NERDTreeFind

" Highlight trailing whitespace and allow automatic removal thereof.
highlight ExtraWhitespace ctermfg=15 ctermbg=4 guifg=#CF6A4C guibg=#420E09
match ExtraWhitespace /\s\+$\| \+\ze\t/

" automatically remove trailing whitespace
autocmd FileType c,ruby,r,cpp autocmd BufWritePre <buffer> :%s/\s\+$\| \+\ze\t//e

" magically leave insert mode with double j, which is confusing because 
imap jj <Esc>

" ====================================
" Stuff from JJ Buckley
" ====================================
" Using Pathogen to bundle plugins, etc
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

" Stupid DOS...
set shellslash

" Make my shell take commands (-c)  as if I'm logged in (-l)
set shellcmdflag=-cl

" Long lines are (often) hard to read
set textwidth=80

" The usual shiftwidth things
set shiftwidth=2
set tabstop=2
set expandtab

" Incremental search
set incsearch

" Useful grep
set grepprg=grep\ -rinsE

" Always cd to the directory of the current file - NO!
" set noautochdir

" Ignore white-space changes in diffs, and use filler lines to keep split-diffs
" symmetrical.
set diffopt=filler,iwhite

" Shell-like completion
set wildmenu
set wildmode=list:longest

" Set the title in shells
set title

" Show more lines around the cursor when scrolling
set scrolloff=3

" File position info
set ruler

" Disable beep (flash screen instead), to annoy fewer co-workers
set visualbell t_vb=

" Status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2

" Show line numbers
set number

" Allow hiding of modified buffers
set hidden

" Sensible invisibile characters (hit \l to see)
map <Leader>l :set list!<CR>
set listchars=tab:→·,eol:¶,trail:·

" For opening files in the same directory as the current
map <Leader>ew :edit <C-R>=expand("%:p:h") ."/"<CR>
map <Leader>es :split <C-R>=expand("%:p:h") ."/"<CR>
map <Leader>ev :vsplit <C-R>=expand("%:p:h") ."/"<CR>

" I like modelines
set modeline

" ,e - Edit another file in the same directory as the current file.
map ,e :e <C-R>=expand("%:p:h") . "/"<CR>

" Quickfix window - Ctrl-F4 (just like Visual C++), and Shift-F4 to cycle back
map <C-F4> :cwindow<CR>
" With unimpaired.vim, these are mapped to ]q and [q
" map <F4> :cnext<CR>
" map <S-F4> :cNext<CR>

" Spell-check - Me speaky the kweenz inglish
set spelllang=en_gb
map <F7> :setlocal spell!<CR>

" Open a file browser in the current buffer's directory
map <F11> :browse e %:h<CR>

" Hypersearch for word (prompt) - filled in with current file's dir and
" extension, and the cursor is left on the word (prefilled to <cword>).
" This is one I use all the time.
map <F5> :vimgrep /\<<C-R>=expand("<cword>")<CR>\>/j **/*<C-R>=expand("%:e")<CR><C-Left><Left><Left><Left><Left><Left>

if has("gui_running")
  " No toolbar, no menu (in GUI mode)
  set guioptions-=T " no toolbar
  set guioptions-=m " no menu
  set guioptions-=r " no constant right-hand scrollbar
  try
    if has("gui_macvim")
      set guifont=monaco:h18 " My Mac is on a TV, so big fonts, please.
    elseif has("gui_gtk2")
      "set guifont=Monaco\ 10 " You need to download this, most likely.
      set guifont=Monospace\ 11 " Sensible fallback
      colorscheme colorzone
    endif
  catch /.*/
    set guifont=Monospace\ 11 " Sensible fallback
  endtry
else
  "Console is (probably) dark if we're not in the GUI
  set background=dark
end

" Quick text wrapping
command! -nargs=* Wrap set wrap linebreak nolist

" Automatically re-read modified files
set autoread

" If the terminal has more than one colour, or the GUI's running
if &t_Co > 1 || has("gui_running")
  syntax enable " What editor worth its salt doesn't show your syntax?
  colorscheme solarized
  let g:solarized_termcolors= 256

endif

if has("autocmd")
  " File-type detection
  filetype plugin indent on
  " Autocompletion for Ruby (and Rails)
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd User Rails let g:rails_ctags_arguments = '--extra=+f --exclude=.git --exclude=log `rvm gemdir`/gems/*'
  autocmd FileType eruby set textwidth=0
  " Always apply $MYVIMRC after writing. Disabled for now, because it gets
  " pretty memory-hungry.
  " autocmd BufWritePost .vimrc source $MYVIMRC
  " Wipeout fugitive buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif

" Alt right/left/home/previous for buffer jumping
map <M-Right> :bnext<CR>
map <M-Left> :bprevious<CR>
map <M-Home> :bfirst<CR>
map <M-End> :blast<CR>

" Match do/end
runtime! macros/matchit

" Some useful bits from http://writequit.org/blog/?p=195
" If I forgot to sudo vim a file, do that with :w!!
cmap w!! %!sudo tee > /dev/null %

" Enable tags in the user help files
if isdirectory('~/.vim/doc')
  helptags ~/.vim/doc
endif

" Folding
set foldmethod=manual
