include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include("${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__parse_arguments.cmake")



function(cmut__target__print_info target_)

    cmut__utils__parse_arguments("cmut__target__print_info"
        ARG
        ""
        ""
        "COMPONENTS"
        ${ARGN}
        )

    if(ARG_COMPONENTS)
        foreach(component IN LISTS ARG_COMPONENTS)
            list(APPEND targets ${target_}::${component})
        endforeach()
    else()
        set(targets ${target_})
    endif()

    include(CMakePrintHelpers)

    foreach(target IN LISTS targets)

        if(NOT TARGET ${target})
            string(TOLOWER ${target} target_lower)

            if(NOT TARGET ${target_lower})
                cmut_error("\"${target}\" or \"${target_lower}\" is not a target.")
                continue()
            else()
                set(target ${target_lower})
            endif()
        endif()


        set(targetPropertiesToPrint)
        get_target_property(targetType ${target} TYPE)
        if (NOT targetType STREQUAL "INTERFACE_LIBRARY")
            list(APPEND targetPropertiesToPrint LOCATION)
        endif()
        list(APPEND targetPropertiesToPrint
            INTERFACE_INCLUDE_DIRECTORIES
            INTERFACE_LINK_LIBRARIES
        )

        cmake_print_properties(
            TARGETS
                ${target}
            PROPERTIES ${targetPropertiesToPrint}
        )
    endforeach()

endfunction()
