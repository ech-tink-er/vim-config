let s:component_min_widths = {
    \ 'full_mode': 68,
    \ 'file_relativepath': 107,
    \ 'file_name': 30,
    \ 'flags': 40,
    \ 'filetype': 120,
    \ 'filedata': 140,
    \ 'percent': 63,
    \
    \ 'lineinfo_glyph': 56,
    \ 'lineinfo_max_lines': 56,
    \ 'lineinfo': 51,
    \
    \ 'noscrollbar': 93,
    \ 'nerd_tree_dir': 56,
    \ 'buffergator': 25,
    \
    \ 'readonly': 65,
    \ 'modified': 65,
\ }

function! s:GetSpecial()
    if exists('b:NERDTree')
        return 'NERDTree'
    elseif exists('b:buffergator_catalog_viewer')
        return 'Buffergator'
    elseif exists('b:plug_preview')
        return 'Plug'
    endif

    return ''
endfunction

" Mode
let s:mode_map = {
    \ 'n': 'NORMAL',
    \
    \ 'i': 'INSERT',
    \
    \ 'R': 'REPLACE',
    \ 'Rv': 'R-VIRTUAL',
    \
    \ 'v': 'VISUAL',
    \ 'V': 'V-LINE',
    \ '': 'V-BLOCK',
    \
    \ 's': 'SELECT',
    \ 'S': 'S-LINE',
    \ '': 'S-BLOCK',
    \
    \ 'c': 'COMMAND',
    \ 't': 'TERMINAL',
    \
    \ 'NERDTree': 'NERD',
    \ 'Buffergator': 'BUFFERS',
    \ 'Plug': 'Plug',
\ }

let s:brief_mode_map = {
    \ 'n': 'N',
    \
    \ 'i': 'I',
    \
    \ 'R': 'R',
    \ 'Rv': 'RV',
    \
    \ 'v': 'V',
    \ 'V': 'VL',
    \ '': 'VB',
    \
    \ 's': 'S',
    \ 'S': 'SL',
    \ '': 'SB',
    \
    \ 'c': 'C',
    \ 't': 'T',
    \
    \ 'NERDTree': 'NR',
    \ 'Buffergator': 'BF',
    \ 'Plug': 'Plug',
\ }

function! lightline#components#get_mode()
    let l:default = 'n'

    let l:map = s:mode_map
    if winwidth(0) < s:component_min_widths.full_mode
        let l:map = s:brief_mode_map
    endif

    let l:mode = s:GetSpecial()

    let l:mode = l:mode == '' ? mode(1) : l:mode

    if has_key(l:map, l:mode)
        return l:map[l:mode]
    endif

    return l:map[l:default]
endfunction

" File
function! lightline#components#should_display_file()
    return s:GetSpecial() == ''
endfunction

function! lightline#components#get_file()
    if !lightline#components#should_display_file() ||
        \ winwidth(0) < s:component_min_widths.file_name
        return ''
    elseif winwidth(0) >= s:component_min_widths.file_relativepath
        return expand('%')
    else
        return expand('%:t')
    endif
endfunction

" Flags
function! s:StatusGetFlags()
    let l:flags = [
        \ &previewwindow ? 'PRV' : '',
        \ &buftype == 'help' ? 'HELP' : '',
        \ &readonly ? 'RO' : '',
        \ !&modifiable ? '-' : '',
        \ &modified ? '+' : '',
    \]

    return filter(l:flags, {i, value -> value != ''})
endfunction

let s:lc.flags = {}

function! lightline#components#should_display_flags(...)
    if s:GetSpecial() != ''
        return 0
    endif

    if a:0
        let l:flags = a:1
    else
        let l:flags = s:StatusGetFlags()
    endif

    return !empty(l:flags)

endfunction

function! lightline#components#get_flags()
    let l:flags = s:StatusGetFlags()

    if !lightline#components#should_display_flags(l:flags) ||
        \ winwidth(0) < s:component_min_widths.flags
        return ''
    endif

    let l:flags = map(l:flags, {i, value ->
        \ printf(g:fat_bracket_format, value)
    \ })

    return join(l:flags, ' ')
endfunction

" FileType
function! lightline#components#should_display_filetype()
    return s:GetSpecial() == '' && &filetype != ''
endfunction

function! lightline#components#get_filetype()
    if !lightline#components#should_display_filetype() ||
        \ winwidth(0) < s:component_min_widths.filetype
        return ''
    endif

    return &filetype
endfunction

" FileData
function! lightline#components#should_display_filedata()
    if s:GetSpecial() != '' || (&fileencoding == '' && &fileformat == '')
        return 0
    endif

    return 1
endfunction

function! lightline#components#get_filedata()
    if !lightline#components#should_display_filedata() ||
        \ winwidth(0) < s:component_min_widths.filedata
        return ''
    endif

    let l:data = &fileencoding

    let l:data .= &fileformat == '' ? '' : '[' . &fileformat . ']'

    return l:data
endfunction

" Percent
function! lightline#components#should_display_percent()
    return s:GetSpecial() == ''
endfunction

function! lightline#components#get_percent()
    if !lightline#components#should_display_percent() ||
        \ winwidth(0) < s:component_min_widths.percent
        return ''
    endif

    let l:percent = ((line('.') * 1.0) / line('$')) * 100

    return printf('%3d%%', float2nr(l:percent))
endfunction

" LineInfo
function! lightline#components#should_display_lineinfo()
    let l:special = s:GetSpecial()
    return l:special == '' || l:special == 'Plug'
endfunction

function! lightline#components#get_lineinfo()
    let l:winwidth = winwidth(0)

    if !lightline#components#should_display_lineinfo() ||
        \ l:winwidth < s:component_min_widths.lineinfo
        return ''
    endif

    let l:line = printf('%02d', line('.'))
    let l:col = printf('%02d', col('.'))
    let l:glyph = ''
    let l:max_lines = ''

    if l:winwidth >= s:component_min_widths.lineinfo_glyph
        let l:glyph = '☰ '
    endif

    if l:winwidth >= s:component_min_widths.lineinfo_max_lines
        let l:max_lines = printf('/%d', line('$'))
    endif

    return printf('%s[%s%s : %s]', l:glyph, l:line, l:max_lines, l:col)
endfunction

" NoScrollbar
function! lightline#components#should_display_noscrollbar()
    return s:GetSpecial() == ''
endfunction

function! lightline#components#get_noscrollbar()
    if !lightline#components#should_display_noscrollbar() ||
        \ winwidth(0) < s:component_min_widths.noscrollbar
        return ''
    endif

    return noscrollbar#statusline(20,'■','◫',['◧'],['◨'])
endfunction

" NERDTree
function! lightline#components#should_display_nerd_tree_dir()
    return s:GetSpecial() == 'NERDTree'
endfunction

function! lightline#components#get_nerd_tree_dir()
    if !lightline#components#should_display_nerd_tree_dir() ||
        \ winwidth(0) < s:component_min_widths.nerd_tree_dir
        let g:dont = 1
        return ''
    endif

    return b:NERDTree.root.path.str()
endfunction

" Buffergator
function! lightline#components#should_display_buffergator()
    return s:GetSpecial() == 'Buffergator'
endfunction

function! lightline#components#get_buffergator()
    if !lightline#components#should_display_buffergator() ||
        \ winwidth(0) < s:component_min_widths.buffergator ||
        \ !has_key(b:buffergator_catalog_viewer, 'buffers_catalog')
        return ''
    endif

    let l:buffers_count = len(b:buffergator_catalog_viewer.buffers_catalog)

    return printf('Buffer %d of %d', line('.'), l:buffers_count)
endfunction

" Tabs
function! lightline#components#get_tabnum(tab)
    return printf(g:fat_bracket_format, a:tab)
endfunction

function! lightline#components#get_wincount(tab)
    let l:win_count = len(tabpagebuflist(a:tab))

    if l:win_count < 2
        return ''
    endif

    return printf('|%d|', l:win_count)
endfunction
