# Copyright (c) 2016, David Callu
# All rights reserved.

# Try to find boost-experimental di header-only library
#
# Input variables:
#     DI_ROOT - turtle installation root
#
# Output variables:
#     DI_INCLUDE_DIR - include directories



find_path(di_INCLUDE_DIR
    NAMES
    "boost/di.hpp"
    HINTS
    "${DI_ROOT}"
    ENV
    "DI_ROOT"
    PATH_SUFFIXES
    "include"
    )

# handle the QUIETLY and REQUIRED arguments and set DI_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(di DEFAULT_MSG di_INCLUDE_DIR)

mark_as_advanced(di_INCLUDE_DIR)

if(di_FOUND AND (NOT TARGET di::di))

    add_library(di::di INTERFACE IMPORTED)

    if(di_INCLUDE_DIR)
        set_target_properties(di::di PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${di_INCLUDE_DIR}")
    endif()

endif()
