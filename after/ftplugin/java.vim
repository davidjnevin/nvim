if &filetype == "java"
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set softtabstop=4
    set smartindent
    set autoindent
	set nolist
    " Disable auto commenting
    autocmd FileType java setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    " Disable line continuation characters (backslash at the end of the line)
    autocmd FileType java setlocal formatoptions-=\\

    " " Enable C++11 features
    " let g:cpp_class_scope_highlight = 1
    " let g:cpp_member_variable_highlight = 1
    " let g:cpp_experimental_simple_template_highlight = 1
endif
