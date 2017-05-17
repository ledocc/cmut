# - Locate google_breakpad paths and libraries
# This module defines:
#  GoogleBreakpad_INCLUDE_DIR       - where to find includes.
#  GoogleBreakpad_INCLUDES          - list of include dirs
#  GoogleBreakpad_CLIENT_LIBRARIES  - the libraries to link against to use breakpad_client.
#  GoogleBreakpad_LIBRARIES         - the libraries to link against to use breakpad.
#

if(CMAKE_HOST_WIN32)
    set(PLATFORM_ID windows)
elseif(CMAKE_HOST_APPLE)
    set(PLATFORM_ID mac)
elseif(CMAKE_HOST_UNIX)
    set(PLATFORM_ID linux)
else()
    message(STATUS "google_breakpad not define for this platform : ${CMAKE_SYSTEM_NAME}")
endif()



set(_GoogleBreakpad_PATH_WHERE_SEARCH ENV GoogleBreakpad_DIR)



######################
# define search macro
######################
macro( _googleBreakpad_find_library var_prefix library_name paths path_suffix_release path_suffix_debug)

    find_library(${var_prefix}_LIBRARY_RELEASE ${library_name}
                 HINTS ${paths}
                 PATH_SUFFIXES ${path_suffix_release})

    find_library(${var_prefix}_LIBRARY_DEBUG ${library_name}
                 HINTS ${paths}
                 PATH_SUFFIXES ${path_suffix_debug})

    if(${var_prefix}_LIBRARY_RELEASE AND ${var_prefix}_LIBRARY_DEBUG)
       set(${var_prefix}_LIBRARIES
           optimized ${${var_prefix}_LIBRARY_RELEASE}
           debug     ${${var_prefix}_LIBRARY_DEBUG} )
    elseif(${var_prefix}_LIBRARY_RELEASE)
       set(${var_prefix}_LIBRARIES ${${var_prefix}_LIBRARY_RELEASE} )
    elseif(${var_prefix}_LIBRARY_DEBUG)
       set(${var_prefix}_LIBRARIES ${${var_prefix}_LIBRARY_DEBUG} )
    endif()


mark_as_advanced(
  ${var_prefix}_LIBRARIES
  ${var_prefix}_LIBRARY_RELEASE
  ${var_prefix}_LIBRARY_DEBUG
)

endmacro()





#####################
# search include path
#####################
find_path(GoogleBreakpad_INCLUDE_DIR client/${PLATFORM_ID}/handler/exception_handler.h
          HINTS ${_GoogleBreakpad_PATH_WHERE_SEARCH}
          PATH_SUFFIXES include/breakpad
          )

set(GoogleBreakpad_INCLUDE_DIRS ${GoogleBreakpad_INCLUDE_DIR})

find_program(GoogleBreakpad_DUMP_SYMS dump_syms)



################################
# search breakpad_client library
################################
if(CMAKE_HOST_WIN32)
    _googleBreakpad_find_library(
        GoogleBreakpad_COMMON common
        "${_GoogleBreakpad_PATH_WHERE_SEARCH}"
        lib/Release lib/Debug
    )
    _googleBreakpad_find_library(
        GoogleBreakpad_CRASH_GENERATION_CLIENT crash_generation_client
        "${_GoogleBreakpad_PATH_WHERE_SEARCH}"
        lib/Release lib/Debug
    )
    _googleBreakpad_find_library(
        GoogleBreakpad_CRASH_GENERATION_SERVER crash_generation_server
        "${_GoogleBreakpad_PATH_WHERE_SEARCH}"
        lib/Release lib/Debug
    )
    _googleBreakpad_find_library(
        GoogleBreakpad_EXCEPTION_HANDLER exception_handler
        "${_GoogleBreakpad_PATH_WHERE_SEARCH}"
        lib/Release lib/Debug
    )


    set(
        GoogleBreakpad_LIBRARIES
        ${GoogleBreakpad_COMMON_LIBRARIES}
        ${GoogleBreakpad_CRASH_GENERATION_CLIENT_LIBRARIES}
        ${GoogleBreakpad_CRASH_GENERATION_SERVER_LIBRARIES}
        ${GoogleBreakpad_EXCEPTION_HANDLER_LIBRARIES}
    )

    include(FindPackageHandleStandardArgs)

    set(__GoogleBreakpad_LIBRARIES_LIST
        GoogleBreakpad_COMMON_LIBRARIES
        GoogleBreakpad_CRASH_GENERATION_CLIENT_LIBRARIES
        GoogleBreakpad_CRASH_GENERATION_SERVER_LIBRARIES
        GoogleBreakpad_EXCEPTION_HANDLER_LIBRARIES
    )

elseif(CMAKE_HOST_APPLE)
elseif(CMAKE_HOST_UNIX)
    _googleBreakpad_find_library(
        GoogleBreakpad_CLIENT breakpad_client
        "${_GoogleBreakpad_PATH_WHERE_SEARCH}"
        lib lib
    )
    _googleBreakpad_find_library(
        GoogleBreakpad breakpad
        "${_GoogleBreakpad_PATH_WHERE_SEARCH}"
        lib lib
    )

    set(
        GoogleBreakpad_LIBRARIES
        ${GoogleBreakpad_LIBRARIES}
        ${GoogleBreakpad_CLIENT_LIBRARIES}
    )

    set(__GoogleBreakpad_LIBRARIES_LIST
            GoogleBreakpad_LIBRARIES
            GoogleBreakpad_CLIENT_LIBRARIES
    )

    set(GoogleBreakpad_DEFINITIONS __STDC_FORMAT_MACROS)

endif()

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(
    GoogleBreakpad FOUND_VAR GoogleBreakpad_FOUND
    REQUIRED_VARS
        GoogleBreakpad_INCLUDE_DIRS
        ${__GoogleBreakpad_LIBRARIES_LIST}
        GoogleBreakpad_DUMP_SYMS
    )
