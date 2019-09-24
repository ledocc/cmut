
function( cmut__log__dev origin message )

    cmut__log__function_name_to_scope_name( scope_name ${origin} )

    cmut_message(STATUS "dev" "${scope_name} :\n${message}")

endfunction()
