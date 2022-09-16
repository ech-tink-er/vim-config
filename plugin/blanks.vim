if !exists('blanks')
    let blanks = {}
endif

if (has_key(blanks, 'load') && !blanks.load) ||
    \ (has_key(blanks, 'loaded') && blanks.loaded)
    finish
endif

function s:AddBlanks(mode, direction)
    if a:mode == 'n'
        let l:line = line('.') - 1 + a:direction
    elseif a:mode == 'v'
        let l:line = a:direction ? line("'>") : line("'<") - 1
    endif

    let l:blanks = repeat([''], v:count ? v:count : 1)

    call append(l:line, l:blanks)
endfunction

nnoremap <silent> <plug>AddBlanksAbove :<c-u>call <sid>AddBlanks('n', 0)<cr>
nnoremap <silent> <plug>AddBlanksBelow :<c-u>call <sid>AddBlanks('n', 1)<cr>

xnoremap <silent> <plug>AddBlanksAbove :<c-u>call <sid>AddBlanks('v', 0)<cr>gv
xnoremap <silent> <plug>AddBlanksBelow :<c-u>call <sid>AddBlanks('v', 1)<cr>gv

let blanks.loaded = 1
