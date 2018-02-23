include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



# This option control the "ccache" mode.
# When ON, ccache is use to speedup compilation
function(cmut__config__option_ccache defaultValue)

    if(NOT DEFINED CCache_FOUND)
        find_program(CCache_COMMAND ccache)
    endif()

    if(NOT CCache_COMMAND)
        return()
    endif()

    option(CMUT__CONFIG__CCACHE "Set to OFF to not use ccache." ${defaultValue})
    cmut_info("ccache mode is ${CMUT__CONFIG__CCACHE}")


    if(CMUT__CONFIG__CCACHE)

        __cmut__config__set_compiler_launcher_if_not_defined(CMAKE_C_COMPILER_LAUNCHER)
        __cmut__config__set_compiler_launcher_if_not_defined(CMAKE_CXX_COMPILER_LAUNCHER)

    endif()

endfunction()


macro(__cmut__config__set_compiler_launcher_if_not_defined var)
    if (${var})
        cmut_error("[cmut][config][ccache] - ${var} already defined on \"${${var}}\. Can't use ccache")
    endif()

    set(${var}   "${CCache_COMMAND}" PARENT_SCOPE)
endmacro()
