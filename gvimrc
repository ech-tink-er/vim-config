" GVIM-PLUGINS are loaded and configured from vimrc-plugins

"------GVIM-MAPPINGS------
set mouse =a
set mousemodel =extend

map <2-RightMouse> <nop>
map <3-RightMouse> <nop>
map <4-RightMouse> <nop>

map <MiddleMouse> <nop>
map <2-MiddleMouse> <nop>
map <3-MiddleMouse> <nop>
map <4-MiddleMouse> <nop>

function! ToggleVisualKey()
    let l:mode = mode()

    if l:mode == 'v'
        return 'V'
    elseif l:mode == 'V'
        return "\<c-v>"
    elseif l:mode == "\<c-v>"
        return 'v'
    else
        return '\<nop\>'
    endif
endfunction

nnoremap <MiddleMouse> V
xnoremap <expr> <MiddleMouse> ToggleVisualKey()

noremap <silent> <space><cr> :GvimTweakToggleFullScreen<CR>

"------DISPLAY-SETTINGS------
set guioptions =c!

" set renderoptions =type:directx
" set rop=type:directx,gamma:1.8,contrast:0.5,level:0.5,geom:1,renmode:5,taamode:1

" Window position and size.
winpos 555 20
set lines =66
set columns =120

set winaltkeys =no "No alt keys for gui menus

set guifont =Hack:h9
colorscheme molokai_mod

" Set indent guides
let &listchars = 'tab:┇\ ' "For tabs
