runtime macros/varrays.vim
let s:table = VARRAY_new()
call VARRAY_split(s:table,' ','la premiere va devant')

let s:printme = VARRAY_pop(s:table)
while s:printme != 'VARRAY_STATE_EMPTY'
    echo s:printme
    let s:printme = VARRAY_pop(s:table)
endwhile
