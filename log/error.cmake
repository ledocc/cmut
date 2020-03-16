include_guard(GLOBAL)

include("${CMAKE_CURRENT_LIST_DIR}/level.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/format.cmake")



function( cmut__log__error origin message )

    cmut__log__format__function_name_to_scope_name( scope_name ${origin} )

    cmut__log__format( error "${scope_name} :\n${message}")

endfunction()
