include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()

include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__parse_arguments.cmake)


###############################################################################
# define CMUT_CXX_FLAGS_WARNING with compiler warning flags
#
# replace warning flag in CMAKE_CXX_FLAGS by CMUT_CXX_FLAGS_WARNING ones
###############################################################################



function(cmut__build__enable_warning)

    cmut__utils__parse_arguments(
        cmut__build__enable_warning
        __ARGS
        "AGGRESSIVE;WARNING_AS_ERROR"
        ""
        ""
        ${ARGN}
    )

cmut_info("cmut__build__enable_warning cmut__build__enable_warning ${__ARGS_AGGRESSIVE}")
cmut_info("cmut__build__enable_warning cmut__build__enable_warning ${__ARGS_WARNING_AS_ERROR}")

    # define common variable for any gcc compatible flags, like clang
    set(__CMUT_WARNING_FLAGS_GNU_COMPAT_COMPILER "-Wextra -Wall -Wpedantic")
    set(__CMUT_WARNING_PATTERN_GNU_COMPAT_COMPILER "-W[a-zA-Z0-9-+=]*")

    if(__ARGS_AGGRESSIVE)
        set(__CMUT_WARNING_FLAGS_GNU_COMPAT_COMPILER "${__CMUT_WARNING_FLAGS_GNU_COMPAT_COMPILER} -Wnon-virtual-dtor -Wshadow")
    endif()

    if(__ARGS_WARNING_AS_ERROR)
        set(__CMUT_WARNING_FLAGS_GNU_COMPAT_COMPILER "${__CMUT_WARNING_FLAGS_GNU_COMPAT_COMPILER} -Werror")
    endif()

    #workaround to use MSVC variable as string (cf CMP0054 policy)
    set(__CMUT_MSVC__ "MSVC")

    # define internal variable in function of compiler
    if(CMAKE_CXX_COMPILER_ID STREQUAL __CMUT_MSVC__)
        set(__CMUT_WARNING_FLAGS /W4)
        set(__CMUT_WARNING_FLAGS_PATTERN "/W[0-9]*")
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(__CMUT_WARNING_FLAGS ${__CMUT_WARNING_FLAGS_GNU_COMPAT_COMPILER})
        set(__CMUT_WARNING_FLAGS_PATTERN ${__CMUT_WARNING_PATTERN_GNU_COMPAT_COMPILER})
    elseif((CMAKE_CXX_COMPILER_ID STREQUAL "Clang") OR (CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang"))
        set(__CMUT_WARNING_FLAGS ${__CMUT_WARNING_FLAGS_GNU_COMPAT_COMPILER})
        set(__CMUT_WARNING_FLAGS_PATTERN ${__CMUT_WARNING_PATTERN_GNU_COMPAT_COMPILER})
    else()
        cmut_warn("[cmut] - cmut__build__enable_warning : compiler \"${CMAKE_CXX_COMPILER_ID}\" no supported by this script. No warning flag will be added.")
    endif()

    # add CMUT_CXX_FLAGS_WARNING in cache
    set(CMUT__BUILD__CXX_FLAGS_WARNING ${__CMUT_WARNING_FLAGS} CACHE STRING "Flags use by the compiler to enable warning.")
    cmut_info("Use C++ flags for warning : ${CMUT__BUILD__CXX_FLAGS_WARNING}.")

    if(CMAKE_CXX_FLAGS AND MSVC)
        # remove warning flag provide by cmake
        string(REGEX REPLACE ${__CMUT_WARNING_FLAGS_PATTERN} "" CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS})
    endif()

    # add CMUT_CXX_FLAGS_WARNING to CMAKE_CXX_FLAGS
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMUT__BUILD__CXX_FLAGS_WARNING}")
    list(REMOVE_DUPLICATES CMAKE_CXX_FLAGS)
    set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} PARENT_SCOPE)

    # debug only
    #message("CMAKE_CXX_FLAGS = ${CMAKE_CXX_FLAGS}")

endfunction()
