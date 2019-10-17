




function( cmut__log__debug origin message )

    if(NOT CMUT__LOG__IS_DEBUG_ENABLE)
        return()
    endif()

    cmut__log__function_name_to_scope_name( scope_name ${origin} )
    cmut_message(STATUS "debug" "${scope_name} : ${message}" )

endfunction()

function( cmut__log__debug_if origin message flag)

    if(NOT ${flag})
        return()
    endif()

    cmut__log__function_name_to_scope_name( scope_name ${origin} )
    cmut_message(STATUS "debug" "${scope_name} : ${message}" )

endfunction()
