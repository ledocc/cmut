

macro(lg_set_default variable )

    if( NOT DEFINED ${variable} )
        set( ${variable} ${ARGN} )
    endif()

endmacro()
