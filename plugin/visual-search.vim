if !exists('visual_search')
    let visual_search = {}
endif

if (has_key(visual_search, 'load') && !visual_search.load) ||
    \ (has_key(visual_search, 'loaded') && visual_search.loaded)
    finish
endif

if !has_key(visual_search, 'register')
    let visual_search.register = 'a'
endif

function! s:SaveRegister(register)
    let b:hold_register = {
        \ 'value': getreg(a:register),
        \ 'type': getregtype(a:register)
    \ }
endfunction

function! s:RestoreRegister(register)
    call setreg(a:register, b:hold_register.value, b:hold_register.type)
endfunction

function! s:MakeKeySequence(direction)
    let func_call_pattern = ":\<c-u>call %s(visual_search.register)\<cr>"

    let save_register_name = get(function('s:SaveRegister'), 'name')
    let restore_register_name = get(function('s:RestoreRegister'), 'name')

    let search_cmd = a:direction ? '/' : '?'

    let key_sequence = printf(func_call_pattern, save_register_name)
    let key_sequence .= printf(
        \ "gv\"%sy%s\<c-r>%s\<cr>",
        \ g:visual_search.register,
        \ search_cmd,
        \ g:visual_search.register
    \ )
    let key_sequence .= printf(func_call_pattern, restore_register_name)

    return key_sequence
endfunction

nnoremap <silent> <expr> <plug>VisualSearchPrev <sid>MakeKeySequence(0)
nnoremap <silent> <expr> <plug>VisualSearchNext <sid>MakeKeySequence(1)
xnoremap <silent> <expr> <plug>VisualSearchPrev <sid>MakeKeySequence(0)
xnoremap <silent> <expr> <plug>VisualSearchNext <sid>MakeKeySequence(1)

let visual_search.loaded = 1
