

include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



# This option control the "cppcheck" mode.
# When ON, all c/cxx compiled file is tested by cppcheck
function(cmut__config__option_cppcheck defaultValue)

    if(NOT DEFINED cppcheck_FOUND)
        find_package(cppcheck)
    endif()

    if(NOT cppcheck_FOUND)
        return()
    endif()

    option(CMUT__CONFIG__CPPCHECK "Set to ON to use cppcheck." ${defaultValue})
    cmut_info("[cmut][config] - cppcheck mode is ${CMUT__CONFIG__CPPCHECK}")


    if(CMUT__CONFIG__CPPCHECK)

        cmut__utils__parse_arguments(cmut__config__option_cppcheck
            __PARAM
            ""
            ""
            "OPTIONS"
            ${ARGN})

        set(cppcheck_commandLine "${cppcheck_COMMAND}")
        if(NOT ${__PARAM_OPTIONS} STREQUAL "")
            list(APPEND cppcheck_commandLine ${__PARAM_OPTIONS})
        endif()


        set(CMAKE_C_CPPCHECK   "${cppcheck_commandLine}" PARENT_SCOPE)
        set(CMAKE_CXX_CPPCHECK "${cppcheck_commandLine}" PARENT_SCOPE)

    endif()

endfunction()
