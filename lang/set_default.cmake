

function(cmut__lang__set_default variable )

    if( NOT DEFINED ${variable} )

        set( ${variable} ${ARGN} PARENT_SCOPE )

    endif()

endfunction()
