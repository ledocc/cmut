
macro(cmut__lang__arg__set_if_defined param variable)

    if( DEFINED ${__cmut__lang__arg__current_prefix}_${param} )
        set( ${variable} ${ARGN} )
    endif()

endmacro()

macro(cmut__lang__arg__add_if_defined param variable)

    if( DEFINED ${__cmut__lang__arg__current_prefix}_${param} )
        list( APPEND ${variable} ${ARGN} )
    endif()

endmacro()


macro(cmut__lang__arg__set_if_defined_or_unset param variable)

    if( DEFINED ${__cmut__lang__arg__current_prefix}_${param} )
        set( ${variable} ${ARGN} )
    else()
        unset( ${variable} )
    endif()

endmacro()
