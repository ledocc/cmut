

macro(cmut__lang__arg__set_default arg value)

    if( NOT DEFINED ${__cmut__lang__arg__current_prefix}_${arg} )
        set( ${__cmut__lang__arg__current_prefix}_${arg} "${value}" )
    endif()

endmacro()


macro(cmut__lang__arg__set_cmake_or_default arg cmake_variabe value)

    if( NOT DEFINED ${__cmut__lang__arg__current_prefix}_${arg} )
        if( DEFINED ${cmake_variable} )
            set( ${__cmut__lang__arg__current_prefix}_${arg} "${cmake_variable}" )
        else()
            set( ${__cmut__lang__arg__current_prefix}_${arg} "${value}" )
        endif()
    endif()

endmacro()
