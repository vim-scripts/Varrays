if exists("loaded_varrays")
    finish
endif
let loaded_varrays = 1
let s:key = 0

function String2arguments(string,separator)
    return '"' . substitute(escape(a:string,'\"'),a:separator,'","','g') . '"'
endfunction

"""""""""" basic array functions

function VARRAY_new()
    let s:key = s:key + 1
    let s:_{s:key}_maxBound=10000
    let s:_{s:key}_minBound=10000
    let s:_{s:key}_index=10000
    return s:key
endfunction

function VARRAY_push(name,...)
    let l:index = 1

    " do -1 to be in peace with l:index
    let l:oldmax = s:_{a:name}_maxBound - 1
    let l:min = s:_{a:name}_minBound

    while a:0 >= l:index
	exec 'let s:_' . a:name . '_' . ( l:index + l:oldmax ) . '= a:' . l:index
	let l:index = l:index + 1
    endwhile
    let s:_{a:name}_maxBound = l:oldmax + l:index
endfunction

function VARRAY_split(name,separator,string)
    exec 'call VARRAY_push('. a:name . ',' String2arguments(a:string,a:separator) . ')' 
endfunction

function VARRAY_pop(name)
    let l:sizeof = s:_{a:name}_maxBound - s:_{a:name}_minBound
    if l:sizeof
	let l:index= s:_{a:name}_maxBound - 1
	let l:result = s:_{a:name}_{l:index}
	unlet s:_{a:name}_{l:index}
	let s:_{a:name}_maxBound = l:index 
	return l:result
    else
	return 'VARRAY_STATE_EMPTY'
    endif
endfunction

function VARRAY_unshift(name,...)
    let l:counter = a:0

    let l:max = s:_{a:name}_maxBound
    let l:min = s:_{a:name}_minBound
    if l:min  == l:max
	let l:index = l:max - 1 
    else
	let l:index = l:max
    endif

    while l:counter > 0
	let l:index= l:index - 1
	exec 'let s:_' . a:name . '_' . l:index . '= a:' . l:counter
	let l:counter = l:counter - 1
    endwhile
    let s:_{a:name}_maxBound = l:index  
endfunction

function VARRAY_length(name)
    return s:_{a:name}_maxBound - s:_{a:name}_minBound
endfunction

function VARRAY_elementAt(name,element)
    let l:realindex = s:_{a:name}_maxBound - s:_{a:name}_minBound + a:element
    return s:_{a:name}_{l:realindex}
endfunction

"""""""""" give memory back
" delete or clean an array

function VARRAY_clean(name)
    let l:index = s:_{a:name}_minBound
    let l:max = s:_{a:name}_maxBound
    while l:index < l:max
	unlet s:_{a:name}_{l:index}
	let l:index = l:index + 1
    endwhile
    let s:_{a:name}_maxBound=10000
    let s:_{a:name}_minBound=10000
    let s:_{a:name}_index=10000
endfunction

function VARRAY_delete(name)
    call VARRAY_clean(a:name)
    unlet s:_{a:name}_maxBound
    unlet s:_{a:name}_minBound
    unlet s:_{a:name}_index
endfunction

"""""""""" Cursor functions
" functions that help to browse the array

function VARRAY_setCursorAtElement(name,value)
    let s:_{a:name}_index= s:_{a:name}_minBound + a:value
endfunction

function VARRAY_setCursorAtBottom(name)
    let s:_{a:name}_index= s:_{a:name}_minBound
endfunction

function VARRAY_setCursorAtTop(name)
    let s:_{a:name}_index= s:_{a:name}_maxBound - 1
endfunction

function VARRAY_getCursor(name)
    return s:_{a:name}_index - s:_{a:name}_minBound
endfunction

function VARRAY_exists(name)
    let l:index = s:_{a:name}_index
    if l:index >= s:_{a:name}_minBound &&  l:index < s:_{a:name}_maxBound
	return 1
    else
	return 0
    endif
endfunction

function VARRAY_here(name)
    return s:_{a:name}_{s:_{a:name}_index}
endfunction

function VARRAY_down(name)
    let l:index = s:_{a:name}_index
    let l:result = s:_{a:name}_{l:index}
    let s:_{a:name}_index = l:index - 1
    return l:result
endfunction

function VARRAY_up(name)
    let l:index = s:_{a:name}_index
    let l:result = s:_{a:name}_{l:index}
    let s:_{a:name}_index = l:index + 1
    return l:result
endfunction

""""" Debbugging functions 

function VARRAY_getInternal(array,value)
    return s:_{a:array}_{a:value}
endfunction

function VARRAY_dump(name)
    let l:index = s:_{a:name}_minBound
    let l:max = s:_{a:name}_maxBound
    while l:index < l:max
	echo l:index . ' : ' . s:_{a:name}_{l:index}
	let l:index = l:index + 1
    endwhile
endfunction
