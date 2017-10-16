

include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



# This option control the "include what you use" mode.
# When ON, all c/cxx comiler file is tested by iwyu, and useless include is reported at compile time
function(cmut__config__option_clang_tidy defaultValue)

    if(NOT DEFINED ClangTidy_FOUND)
        find_package(ClangTidy)
    endif()

    if(NOT ClangTidy_FOUND)
        return()
    endif()

    option(CMUT__CONFIG__CLANG_TIDY "Set to ON to use clang-tidy ()." ${defaultValue})
    cmut_info("clang-tidy mode is ${CMUT__CONFIG__CLANG_TIDY}")


    if(CMUT__CONFIG__CLANG_TIDY)

        cmut__utils__parse_arguments(cmut__config__option_clang_tidy
            __PARAM
            ""
            ""
            "OPTIONS"
            ${ARGN})

        set(ClangTidy_commandLine "${ClangTidy_COMMAND}")
        if(NOT ${__PARAM_OPTIONS} STREQUAL "")
            list(APPEND ClangTidy_commandLine ${__PARAM_OPTIONS})
        endif()


        set(CMAKE_C_CLANG_TIDY   "${ClangTidy_commandLine}" PARENT_SCOPE)
        set(CMAKE_CXX_CLANG_TIDY "${ClangTidy_commandLine}" PARENT_SCOPE)

    endif()

endfunction()
