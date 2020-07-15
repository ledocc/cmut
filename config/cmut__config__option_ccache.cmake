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
    cmut__log__info(cmut__config__option_ccache "ccache mode is ${CMUT__CONFIG__CCACHE}")

    if(CMUT__CONFIG__CCACHE)

        macro(set_compiler_launcher_to_ccache_if_not_defined lang)
            get_filename_component(compiler_path ${CMAKE_${lang}_COMPILER} REALPATH)
            if ("${compiler_path}" STREQUAL "${CCache_COMMAND}")
                cmut__log__info(cmut__config__option_ccache "${lang} compiler is already a link to ccache.")
            else()
                if(DEFINED CMAKE_${lang}_COMPILER_LAUNCHER)
                    cmut__log__error(cmut__config__option_ccache "already defined on \"${${var}}\. Can't use ccache")
                else()
                    set(CMAKE_${lang}_COMPILER_LAUNCHER "${CCache_COMMAND}" PARENT_SCOPE)
                endif()
            endif()
        endmacro()

        set_compiler_launcher_to_ccache_if_not_defined(C)
        set_compiler_launcher_to_ccache_if_not_defined(CXX)
    endif()

endfunction()


