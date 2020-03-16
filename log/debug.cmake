include_guard(GLOBAL)

include("${CMAKE_CURRENT_LIST_DIR}/level.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/format.cmake")



function( cmut__log__debug origin message )

    if(NOT CMUT__LOG__IS_DEBUG_ENABLE)
        return()
    endif()

    cmut__log__format__function_name_to_scope_name( scope_name ${origin} )

    cmut__log__format( debug "${scope_name} : ${message}" )

endfunction()

function( cmut__log__debug_if origin message flag)

    if(NOT ${flag})
        return()
    endif()

    cmut__log__debug( ${origin} "${message}" )

endfunction()
