" Example Vim configuration.
" Copy or symlink to ~/.vimrc or ~/_vimrc.

set nocompatible                  " Must come first because it changes other options.

call pathogen#infect()            " Pathogen plugin loading
syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

" Colors
set t_Co=256
colorscheme zenburn

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignorecase
set wildignore+=tmp/**,.git,public/uploads/tmp,build,node_modules,doc,bower_components

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Line numbers.
set ruler                         " Cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
highlight Search cterm=underline
set showmatch                     " Show matching brackets
" Press Space to turn off highlighting and clear any message already
" displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set autoread                      " Automatically reload file on external change
set autowrite                     " Automatically save files

set novisualbell                  " No annoying flashing

set cursorline                    " Highlight current line.

set list
set listchars=tab:▸\ ,

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp/,.  " Keep swap files in one location

set tabstop=4                    " Global tab width.
set shiftwidth=4                 " And again, related.
set expandtab                    " Use spaces instead of tabs
set softtabstop=4

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

" Indent
set autoindent

" Remap leader
let mapleader = ","

function! <SID>StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Delete trailing whitespace when saving
autocmd BufWritePre * :call <SID>StripTrailingWhitespace()

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" open files in directory of current file
function! DirectoryOfFile()
 return expand('%:h').'/'
endfunction
map <leader>v :view <C-R>=DirectoryOfFile()<cr><cr>

" GoToFile shortcuts
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gj :CommandTFlush<cr>\|:CommandT app/assets/javascripts<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT spec<cr>
map <leader>gr :e config/routes.rb<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT <C-R>=DirectoryOfFile()<cr><cr>

" Fuzzy commands
let g:fuf_modesDisable = ['mrucmd']
map <leader>e :FufFile <C-R>=DirectoryOfFile()<cr><cr>
map <leader>b :FufBuffer<cr>
map <leader>r :FufMruFile<cr>

" cd shortcuts
map <leader>cs :cd ~/dev/schools<cr>
map <leader>cv :cd ~/.vim<cr>
map <leader>cdf :cd ~/dev/dotfiles<cr>

let g:ackprg="ack -H --nocolor --nogroup --column"
map <leader>aa :Ack!<space>""<left>
map <leader>aj :Ack!<space>--type=js<space>--type=coffee<space>""<left>
map <leader>ar :Ack!<space>--type=ruby<space>""<left>
" Highlight current word in all buffers and then ack for it in all files
map <leader>aw *#:Ack!<space><cword><cr>

" Switch to alternate file
nnoremap <leader><leader> <c-^>

" Disable help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Controversial...swap colon and semicolon for easier commands
nnoremap ; :
vnoremap ; :

" Movement
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Keep visual selection after indenting
vnoremap > >gv
vnoremap < <gv

" Window management
map <leader>w <c-w>
map <leader>q :cope<cr>

" shrink quick fix window to fit
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

"Tests
source ~/.vim/cwick-test.vim
map <leader>t :call RunTests()<cr>



"Ruby
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
