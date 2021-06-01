include("${CMAKE_CURRENT_LIST_DIR}/init.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/function_name_to_scope_name.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake")



function( cmut__log__fatal origin message )

    cmut__log__function_name_to_scope_name( scope_name ${origin} )

    cmut_message(FATAL_ERROR "fatal" "${scope_name} :\n${message}")

endfunction()
