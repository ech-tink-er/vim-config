"------IMPORTANT-SETTINGS------
set nocompatible " Vi compatibility
set encoding =utf-8 " Vim internal encoding.

"------ENVIRONMENT-VARIABLES------
let $MYRUNTIME = '~/.vim'
let $VIMRC = expand('$MYRUNTIME/vimrc')
let $GVIMRC = expand('$MYRUNTIME/gvimrc')

"------RUNTIMEPATH------
let s:runtimes = [$VIMRUNTIME, $MYRUNTIME, $MYRUNTIME . '/after']
let &runtimepath = join(s:runtimes, ',')

"------VIMINFO------
let &viminfo .= ',n' . $MYRUNTIME . '/viminfo'

"------GLOBALS------
let g:open_fat_bracket = '❰'
let g:close_fat_bracket = '❱'
let g:fat_bracket_format = g:open_fat_bracket . '%s' . g:close_fat_bracket

"------SETTINGS------
set fileformats =dos,unix,mac
set notimeout " Unfinished mappings don't timeout.
syntax on

" Use the sys clipboard instead of the unnamed register.
set clipboard =unnamed

" Enables filetype detection, filetype indenting, and filetype plugins.
filetype plugin indent on

" Indentation
set tabstop =4
set shiftwidth =0
set expandtab
set autoindent " See also smartindent, cindent and indentexpr.

" Folding
set foldlevelstart =99 " Open all folds when opening a file.
let &viewdir = expand($MYRUNTIME . "/views")

set hidden " Hide buffers don't unload them, when all buffer windows are closed.
let &path = '.,,./**5,**5' " Directories for searching files with :find.
set backspace =2 " Allows you to backspace auto indent.

" By default vim sees numbers with leading zeroes '003' as base 8,
" this makes it use decimal.
set nrformats -=octal

"------DISPLAY-SETTINGS------
set cursorline

" Line Numebers.
set number
set relativenumber

set noshowmode " Mode displayed in statusline.
set showcmd " Shows the current command, at bottom right.
set wildmenu " Menu for command-line completion.
set foldcolumn =1

" Set indent guides for tabs.
let &listchars = 'tab:|\ '

set hlsearch " Search highlighting.
set incsearch " Peek at first search match.

set lazyredraw " Don't redraw screen while executing macros.

set belloff =all " Silence error beeps.
" set showmatch " Move cursor to show matching brace while inserting.

" Windows
set splitright
set splitbelow

" Redraw the status line after entering command-line mode.
autocmd CmdlineEnter * redrawstatus

" Setup Status Line.
set laststatus =2 " Make Status Line always visible.
let &statusline = '%f' " File Path.
let &statusline .= '     ' " Padding.
let &statusline .= '%y' " File Type.
let &statusline .= '  ' " Padding.
let &statusline .= '%m' " Modified.
let &statusline .= '  ' " Padding.
let &statusline .= '%r' " Read-Only.
let &statusline .= '%=' " Switch to right side.
let &statusline .= '[%02.l, %02.c]' " Row and Col.
let &statusline .= '   ' " Padding.
let &statusline .= '[%03.P]' " % of file on screen.

"------PLUGINS------
source $MYRUNTIME/vimrc-plugins

"------VIM-MAPPINGS------
source $MYRUNTIME/vimrc-mappings
