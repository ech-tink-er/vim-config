" Resets line number settings for NERDTree, so it can work with Numbers plugin.
autocmd WinEnter * call <sid>SetLineNumbers()

function s:SetLineNumbers()
    if &filetype == 'nerdtree'
        setlocal number
        setlocal relativenumber
    endif
endfunction
