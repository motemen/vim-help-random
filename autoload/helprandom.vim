let s:tags = []

function! s:load_tags(reload)
    if a:reload == 0
        let s:tags = []
    endif

    if len(s:tags) > 0
        return s:tags
    endif

    for path in split(&runtimepath, ',')
        let tagfile = path . '/doc/tags'
        if filereadable(tagfile)
            let tags = map(readfile(tagfile), 'matchstr(v:val, ''^[^\t]\+'')')
            call extend(s:tags, tags)
        endif
    endfor

    return s:tags
endfunction

" http://vim-users.jp/2009/11/hack98/
" returns: 0 .. n-1
function! s:random(n)
    return matchstr(reltimestr(reltime()), '\.\zs\d\+$') % a:n
endfunction

function! helprandom#random_tag()
    let tags = s:load_tags(0)
    return tags[s:random(len(tags))]
endfunction

function! helprandom#helprandom()
    let tag = helprandom#random_tag()
    execute 'help' tag
endfunction
