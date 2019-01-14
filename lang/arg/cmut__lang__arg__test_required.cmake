


macro(cmut__lang__arg__test_required arg message)

    if(NOT DEFINED ${__cmut__lang__arg__current_prefix}_${arg})
        cmut_fatal(${message})
    endif()

endmacro()
