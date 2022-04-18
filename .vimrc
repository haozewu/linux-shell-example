"将本文件放在~下
syntax on
set autoindent
set smartindent
set cindent
set shiftwidth=4
set ts=4
set expandtab
set ruler
"行号
set number

"设置高亮搜索
set hlsearch

autocmd BufNewFile *.py,*.sh, exec ":call SetTitle()"
let $author_name = "#"
let $author_email = "#"
func SetTitle()
if &filetype == 'sh'
call setline(1,"\########################################################################################################")
call append(line("."), "\# File Name: ".expand("%"))
call append(line(".")+1, "\# Author: ".$author_name)
call append(line(".")+2, "\# mail: ".$author_email)
call append(line(".")+3, "\# Created time: ".strftime("%c"))
call append(line(".")+4, "\#========================================================================================================")
call append(line(".")+5, "\#!/bin/bash")
call append(line(".")+6, "")
else
call setline(1,"\########################################################################################################")
call append(line("."), "\# File Name: ".expand("%"))
call append(line(".")+1, "\# Author: ".$author_name)
call append(line(".")+2, "\# mail: ".$author_email)
call append(line(".")+3, "\# Created time: ".strftime("%c"))
call append(line(".")+4, "\#========================================================================================================")
call append(line(".")+5, "\#!/usr/bin/python")
call append(line(".")+2, "")
endif
autocmd BufNewFile * normal G
endfunction
