"runtime macros/varrays.vim
source varrays.vim

let s:table = VARRAY_new()
call VARRAY_split(s:table,' ','this is')
call VARRAY_split(s:table,' ','my church')


echo '-------- DEBBUGGING : getInternal  ---------------' 
echo ' '
echo 'maxBound : ' . VARRAY_getInternal(s:table,'maxBound')
echo 'minBound : ' . VARRAY_getInternal(s:table,'minBound')
echo ' '
echo '-------- DEBBUGGING : dump  ---------------' 
call VARRAY_dump(s:table)
echo 'end of dump'
echo ' '

echo 'now browse up ' . VARRAY_length(s:table) . ' elements'
echo ' '
while VARRAY_exists(s:table)
    echo VARRAY_up(s:table)
endwhile
echo ' '

echo 'call VARRAY_setCursorAtTop(s:table)'
echo ' '
call VARRAY_setCursorAtTop(s:table)

echo 'browse down'
while VARRAY_exists(s:table)
    echo 'element ' . VARRAY_getCursor(s:table) . ' : ' . VARRAY_down(s:table)
endwhile
echo ' '

echo 'VARRAY_setCursorAtElement(s:table,2)'
call VARRAY_setCursorAtElement(s:table,2)
echo 'real position : ' . VARRAY_getInternal(s:table,'index') . ' index : ' . VARRAY_getCursor(s:table) . ' value : ' . VARRAY_here(s:table)

while VARRAY_exists(s:table)
    echo 'element ' . VARRAY_getCursor(s:table) . ' : ' . VARRAY_up(s:table)
endwhile

echo 'NOW CLEAN'
call VARRAY_clean(s:table)
echo 'cursor : ' .  VARRAY_getCursor(s:table)
echo 'length : ' .  VARRAY_length(s:table) . 'min : ' . VARRAY_getInternal(s:table,'minBound'). 'max : ' . VARRAY_getInternal(s:table,'maxBound')

let emile=s:table
call VARRAY_delete(s:table)

