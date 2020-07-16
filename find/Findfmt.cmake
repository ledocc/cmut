# Copyright (c) 2016, David Callu
# All rights reserved.

# Try to find fmt library
#
# Input variables:
#     FMT_ROOT - fmt installation root
#
# Output variables:
#     fmt_INCLUDE_DIR - fmt include directories
#     fmt_LIBRARY_DIR - fmt lib directories



find_path(fmt_INCLUDE_DIR
    NAMES
    "fmt/format.h"
    HINTS
    "${FMT_ROOT}" "${fmt_ROOT}"
    ENV
    "FMT_ROOT" "fmt_ROOT"
    PATH_SUFFIXES
    "include"
    )

find_library(fmt_LIBRARY
    NAMES
    "fmt" "fmtd"
    HINTS
    "${FMT_ROOT}" "${fmt_ROOT}"
    ENV
    "FMT_ROOT" "fmt_ROOT"
    )

# handle the QUIETLY and REQUIRED arguments and set FMT_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(fmt DEFAULT_MSG fmt_INCLUDE_DIR fmt_LIBRARY)

mark_as_advanced(fmt_INCLUDE_DIR)

if(fmt_FOUND AND (NOT TARGET fmt::fmt))

    add_library(fmt::fmt UNKNOWN IMPORTED)

    if(fmt_INCLUDE_DIR)
        set_target_properties(fmt::fmt PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${fmt_INCLUDE_DIR}")
    endif()
    if(fmt_LIBRARY)
        set_target_properties(fmt::fmt PROPERTIES
            IMPORTED_LOCATION "${fmt_LIBRARY}")
    endif()

endif()
