

function( cmut__utils__list_prepend list )

    set( new_list "" )
    foreach( arg IN LISTS ARGN )
        list(APPEND new_list "${arg}")
    endforeach()

    foreach( arg IN LISTS ${list} )
        list(APPEND new_list "${arg}")
    endforeach()

    set(${list} "${new_list}" PARENT_SCOPE)

endfunction()
