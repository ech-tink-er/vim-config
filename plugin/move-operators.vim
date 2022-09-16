if !exists('move_operators')
    let move_operators = {}
endif

if (has_key(move_operators, 'load') && !move_operators.load) ||
    \ (has_key(move_operators, 'loaded') && move_operators.loaded)
    finish
endif

function! s:Ready(mode, direction)
    let execute = get(funcref('s:Execute'), 'name')
    if a:mode == 'n'
        let from = "'["
        let to = "']"

        let &operatorfunc = execute

        let mapping = "\<esc>g@"
    elseif a:mode == 'v'
        let from = "'<"
        let to = "'>"

        let reselect = v:count ? '' : 'gv'
        let mapping = printf(":\<c-u>call %s()\<cr>%s", execute, reselect)
    else
        throw 'Unknown mode!'
    endif

    if !a:direction
        let address = v:count ? line('.') - v:count - 1 : from . -2
    else
        let address = v:count ? line('.') + v:count : to . 1
    endif

    let b:move_operator = {
        \ 'from': from,
        \ 'to': to,
        \ 'address': address,
    \ }

    return mapping
endfunction

function! s:Execute(...)
    let from = line(b:move_operator.from)
    let to = line(b:move_operator.to)

    try
        exec 'silent' from ',' to 'move' b:move_operator.address

        let lines_count = to - from + 1
        if lines_count > 2
            echo lines_count 'lines moved'
        endif
    catch /\vE14|E134/
    endtry
endfunction

nnoremap <expr> <plug>MoveUpOperator <sid>Ready('n', 0)
nmap <plug>MoveUpOperatorLine <plug>MoveUpOperatorg@
xnoremap <silent> <expr> <plug>MoveUpOperator <sid>Ready('v', 0)

nnoremap <expr> <plug>MoveDownOperator <sid>Ready('n', 1)
nmap <plug>MoveDownOperatorLine <plug>MoveDownOperatorg@
xnoremap <silent> <expr> <plug>MoveDownOperator <sid>Ready('v', 1)

let move_operators.loaded = 1
