if !exists('duplicate_operator')
    let duplicate_operator = {}
endif

if (has_key(duplicate_operator, 'load') && !duplicate_operator.load) ||
    \ (has_key(duplicate_operator, 'loaded') && duplicate_operator.loaded)
    finish
endif

function! s:FormatMessage(base, count)
    if a:base == '' || a:count < 2
        return a:base
    endif

    return printf('%s %s times', a:base, a:count)
endfunction

function! s:DuplicateInLine(line, from, to, count)
    let content = getline(a:line)
    let from = a:from - 1
    let to = a:to - 1
    let target_length = (to - from) + 1

    let prefix = strcharpart(content, 0, from)
    let target = strcharpart(content, from, target_length)
    let suffix = strcharpart(content, to + 1)

    let result = prefix . repeat(target, a:count + 1) . suffix

    call setline(a:line, result)

    let message = printf("'%s' copied", target)

    return s:FormatMessage(message, a:count)
endfunction

function! s:DuplicateLines(from, to, count)
    let lines = getline(a:from, a:to)

    let result = repeat(lines, a:count)

    call append(a:to, result)

    call setpos('.', [0, a:from, 0, 0])
    normal! ^

    let lines_count = (a:to - a:from) + 1
    let new_lines_count = lines_count * a:count
    if new_lines_count < 3
        return ''
    endif

    if lines_count < 2
        let message = 'line copied'
    else
        let message = printf('%s lines copied', lines_count)
    endif

    return s:FormatMessage(message, a:count)
endfunction

function! s:Ready(mode)
    let execute = get(funcref('s:Execute'), 'name')
    if a:mode == 'n'
        let from = "'["
        let to = "']"

        let &operatorfunc = execute

        let mapping = "\<esc>g@"
    elseif a:mode == 'v'
        let from = "'<"
        let to = "'>"

        let type = mode() == 'v' ? "'char'" : "'line'"
        let mapping = printf(":\<c-u>call %s(%s)\<cr>", execute, type)
    else
        throw 'Unknown mode!'
    endif

    let b:duplicate_operator = {
        \ 'from': from,
        \ 'to': to,
        \ 'count': v:count ? v:count : 1,
    \ }

    return mapping
endfunction

function! s:Execute(type)
    let l:count = b:duplicate_operator.count
    let from = line(b:duplicate_operator.from)
    let to = line(b:duplicate_operator.to)

    if a:type == 'char' && (from == to)
        let line = from
        let from = col(b:duplicate_operator.from)
        let to = col(b:duplicate_operator.to)

        let message = s:DuplicateInLine(line, from, to, l:count)
    else
        let message = s:DuplicateLines(from, to, l:count)
    endif

    if message != ''
        echo message
    endif
endfunction

nnoremap <expr> <plug>DuplicateOperator <sid>Ready('n')
nmap <plug>DuplicateOperatorLine <plug>DuplicateOperatorg@
xnoremap <silent> <expr> <plug>DuplicateOperator <sid>Ready('v')

let duplicate_operator.loaded = 1
