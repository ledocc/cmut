



function( cmut__lang__set_if_not_defined variable )

    if( DEFINED ${variable} )
        return()
    endif()

    set( ${variable} ${ARGN} PARENT_SCOPE )

endfunction()
