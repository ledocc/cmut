

include("${CMAKE_CURRENT_LIST_DIR}/set_in_parent_scope.cmake")


macro(lg_return variable)
    lg_set_in_parent_scope( ${result} "${${variable}}" )
    return()
endmacro()

macro(lg_return_value )
    lg_set_in_parent_scope( ${result} "${ARGN}" )
    return()
endmacro()

macro(lg_return_unset)
    lg_unset_in_parent_scope( ${result} )
    return()
endmacro()

