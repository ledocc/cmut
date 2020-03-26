# Copyright (c) 2016, David Callu
# All rights reserved.

# Try to find turtle header-only library
#
# Input variables:
#     TURTLE_ROOT - turtle installation root
#
# Output variables:
#     TURTLE_INCLUDE_DIR - include directories



find_path(Turtle_INCLUDE_DIR
    NAMES
    "turtle/mock.hpp"
    HINTS
    "${TURTLE_ROOT}"
    ENV
    "TURTLE_ROOT"
    PATH_SUFFIXES
    "include"
)

# handle the QUIETLY and REQUIRED arguments and set TURTLE_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Turtle DEFAULT_MSG Turtle_INCLUDE_DIR)

mark_as_advanced(Turtle_INCLUDE_DIR)

if(Turtle_FOUND)

    add_library(turtle::turtle INTERFACE IMPORTED)
    target_compile_definitions(turtle::turtle INTERFACE MOCK_NO_AUTO_PTR)

    if(Turtle_INCLUDE_DIR)
        set_target_properties(turtle::turtle PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${Turtle_INCLUDE_DIR}")
    endif()

endif()
