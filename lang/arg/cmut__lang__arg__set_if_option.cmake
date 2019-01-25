
macro(cmut__lang__arg__set_if_option option variable)

    if( ${__cmut__lang__arg__current_prefix}_${option} )
        set( ${variable} ${ARGN} )
    endif()

endmacro()

macro(cmut__lang__arg__add_if_option option variable)

    if( ${__cmut__lang__arg__current_prefix}_${option} )
        list( APPEND ${variable} ${ARGN} )
    endif()

endmacro()


macro(cmut__lang__arg__set_if_option_or_unset option variable)

    if( ${__cmut__lang__arg__current_prefix}_${option} )
        set( ${variable} ${ARGN} )
    else()
        unset( ${variable} )
    endif()

endmacro()
