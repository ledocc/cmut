# Copyright (c) 2016, David Callu
# All rights reserved.

# Try to find turtle header-only library
#
# Input variables:
#     DATE_ROOT - turtle installation root
#
# Output variables:
#     DATE_INCLUDE_DIR - include directories



find_path(date_INCLUDE_DIR
    NAMES
    "date/date.h"
    HINTS
    "${DATE_ROOT}"
    ENV
    "DATE_ROOT"
    PATH_SUFFIXES
    "include"
    )

find_library(date_LIBRARY NAMES tz )

# handle the QUIETLY and REQUIRED arguments and set TURTLE_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(date DEFAULT_MSG date_INCLUDE_DIR date_LIBRARY)

mark_as_advanced(date_INCLUDE_DIR date_LIBRARY)

if(date_FOUND AND (NOT TARGET date::date))

    add_library(date::date UNKNOWN IMPORTED)

    if(date_INCLUDE_DIR)
        set_target_properties(date::date PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${date_INCLUDE_DIR}")
        set_target_properties(date::date PROPERTIES
            IMPORTED_LOCATION "${date_LIBRARY}")
    endif()

endif()
