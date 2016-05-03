###############################################################################
# define CMUT_CXX_FLAGS_WARNING with compiler warning flags
#
# replace warning flag in CMAKE_CXX_FLAGS by CMUT_CXX_FLAGS_WARNING ones
###############################################################################


# define common variable for any gcc compatible flags, like clang
set(__CMUT_WARNING_FLAGS_GNU_COMPAT_COMPILER "-Wall -Wextra")
set(__CMUT_WARNING_PATTERN_GNU_COMPAT_COMPILER "-W[a-zA-Z0-9]*")


#workaround to use MSVC variable as string (cf CMP0054 policy)
set(__CMUT_MSVC__ "MSVC")

# define internal variable in function of compiler
# message("CMAKE_CXX_COMPILER_ID = ${CMAKE_CXX_COMPILER_ID}")
if(CMAKE_CXX_COMPILER_ID STREQUAL __CMUT_MSVC__)
    set(__CMUT_WARNING_FLAGS /W4)
    set(__CMUT_WARNING_FLAGS_PATTERN "/W[0-9]*")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set(__CMUT_WARNING_FLAGS ${__CMUT_WARNING_FLAGS_GNU_COMPAT_COMPILER})
    set(__CMUT_WARNING_FLAGS_PATTERN ${__CMUT_WARNING_PATTERN_GNU_COMPAT_COMPILER})
elseif((CMAKE_CXX_COMPILER_ID STREQUAL "Clang") OR (CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang"))
    set(__CMUT_WARNING_FLAGS ${__CMUT_WARNING_FLAGS_GNU_COMPAT_COMPILER})
    set(__CMUT_WARNING_FLAGS_PATTERN ${__CMUT_WARNING_PATTERN_GNU_COMPAT_COMPILER})
endif()

# add CMUT_CXX_FLAGS_WARNING in cache
set(CMUT_CXX_FLAGS_WARNING ${__CMUT_WARNING_FLAGS} CACHE STRING "Flags use by the compiler to enable warning.")
message(STATUS "Use C++ flags for warning : ${CMUT_CXX_FLAGS_WARNING}.")

if(CMAKE_CXX_FLAGS AND MSVC)
    # remove warning flag provide by cmake
    string(REGEX REPLACE ${__CMUT_WARNING_FLAGS_PATTERN} "" CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS})
ENDIF()

# add CMUT_CXX_FLAGS_WARNING to CMAKE_CXX_FLAGS
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMUT_CXX_FLAGS_WARNING}")
list(REMOVE_DUPLICATES CMAKE_CXX_FLAGS)

# debug only
#message("CMAKE_CXX_FLAGS = ${CMAKE_CXX_FLAGS}")
