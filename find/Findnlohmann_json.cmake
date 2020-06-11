# Copyright (c) 2016, David Callu
# All rights reserved.

# Try to find turtle header-only library
#
# Input variables:
#     nlohmann_json_ROOT - turtle installation root
#
# Output variables:
#     nlohmann_json_INCLUDE_DIR - include directories



find_path(nlohmann_json_INCLUDE_DIR
    NAMES
    "nlohmann/json.hpp"
    HINTS
    "${nlohmann_json_ROOT}"
    ENV
    "nlohmann_json_ROOT"
    PATH_SUFFIXES
    "include"
    )

# handle the QUIETLY and REQUIRED arguments and set nlohmann_json_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(nlohmann_json DEFAULT_MSG nlohmann_json_INCLUDE_DIR)

mark_as_advanced(nlohmann_json_INCLUDE_DIR)

if(nlohmann_json_FOUND)

    if(NOT TARGET nlohmann_json::nlohmann_json)
        add_library(nlohmann_json::nlohmann_json INTERFACE IMPORTED)

        if(nlohmann_json_INCLUDE_DIR)
            set_target_properties(nlohmann_json::nlohmann_json PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${nlohmann_json_INCLUDE_DIR}")
        endif()
    endif()

endif()
