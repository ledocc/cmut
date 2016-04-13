
include(CMakePrintHelpers)


function(cmut_print_target_properties target)

    cmake_print_properties(
        TARGETS
            ${target}
        PROPERTIES
            LOCATION
            INTERFACE_INCLUDE_DIRECTORIES
            INTERFACE_LINK_LIBRARIES
    )

endfunction()

function(cmut_print_target_interface_properties target)

    cmake_print_properties(
        TARGETS
            ${target}
        PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES
            INTERFACE_LINK_LIBRARIES
    )

endfunction()