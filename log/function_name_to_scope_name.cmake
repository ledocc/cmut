include("${CMAKE_CURRENT_LIST_DIR}/../lang.cmake")


function( cmut__log__function_name_to_scope_name result function_name )

    string( REGEX REPLACE "__" "][" scope_name "${function_name}" )
    set( scope_name "[${scope_name}]" )
    cmut__lang__return( scope_name )

endfunction()
