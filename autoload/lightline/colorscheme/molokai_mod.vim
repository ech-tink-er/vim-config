let s:dark = [ '#000000', 0 ]
let s:black = [ '#232526', 233 ]
let s:gray = [ '#808080', 244 ]
let s:white = [ '#f8f8f2', 234 ]
let s:cyan = [ '#66d9ef', 81 ]
let s:green = [ '#a6e22e', 118 ]
let s:orange = [ '#ef5939', 166 ]
let s:pink = [ '#f92672', 161 ]
let s:yellow = [ '#e6db74', 229 ]

" sat: -77, lum: -45
let s:dull_pink = [ '#9B244E', 161 ]
let s:dull_green = [ '#667E32', 118 ]

let s:p = {
    \ 'normal': {},
	\ 'inactive': {},
	\ 'insert': {},
	\ 'replace': {},
	\ 'visual': {},
	\ 'tabline': {}
\ }

let s:p.normal.left = [ [ s:dark, s:green, "bold" ], [ s:green, s:dark ] ]
let s:p.normal.middle = [ [ s:green, s:black, "italic" ] ]
let s:p.normal.right = [ [ s:pink, s:black, "bold" ], [ s:black, s:pink ] ]
let s:p.normal.error = [ [ s:pink, s:black ] ]
let s:p.normal.warning = [ [ s:yellow, s:black ] ]

let s:p.insert.left = [ [ s:dark, s:cyan, 'bold' ], [ s:cyan, s:dark ] ]
let s:p.insert.middle = [ [ s:black, s:cyan, 'italic' ] ]
let s:p.insert.right = [ [ s:black, s:cyan, 'bold' ], [ s:cyan, s:black ] ]

let s:p.visual.left = [ [ s:dark, s:yellow, 'bold' ], [ s:yellow, s:dark ] ]
let s:p.visual.middle = [ [ s:black, s:yellow, 'italic' ] ]
let s:p.visual.right = [ [ s:black, s:yellow, 'bold' ], [ s:yellow, s:black ] ]

let s:p.replace.left = [ [ s:dark, s:orange, 'bold' ], [ s:orange, s:dark ] ]
let s:p.replace.middle = [ [ s:black, s:orange, 'italic' ] ]
let s:p.replace.right = [ [ s:black, s:orange, 'bold' ], [ s:orange, s:black ] ]

let s:p.inactive.left =  [
    \ [ s:dull_green, s:black, 'bold' ],
    \ [ s:dull_pink, s:black ]
\ ]
let s:p.inactive.middle = [ [ s:dull_pink, s:black, 'italic' ] ]
let s:p.inactive.right = [
    \ [ s:black, s:dull_pink, 'bold' ],
    \ [ s:dull_pink, s:black ]
\ ]
let s:p.tabline.left = [ [ s:pink, s:black, 'bold' ] ]
let s:p.tabline.middle = [ [ s:pink, s:black] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.tabline.tabsel = [ [ s:black, s:pink ] ]

let g:lightline#colorscheme#molokai_mod#palette = lightline#colorscheme#flatten(s:p)
