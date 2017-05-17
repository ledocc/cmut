include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include("${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__parse_arguments.cmake")



function(cmut__target__print_info target_)

    cmut__utils__parse_arguments("cmut__target__print_info"
        ARG
        ""
        ""
        "COMPONENTS"
        )

    if(ARG_COMPONENTS)
        foreach(component IN_LISTS ARG_COMPONENTS)
            list(APPEND targets ${target_}::${component})
        endforeach()
    else()
        set(targets ${target_})
    endif()


    foreach(target IN LISTS ${targets})

        if(NOT TARGET ${target})
            string(TOLOWER ${target} target)
        endif()

        if(NOT TARGET ${target})
            cmut_error("\"${target}\" is not a target.")
            continue()
        endif()

        cmake_print_properties(
            TARGETS
                ${target}
            PROPERTIES
                LOCATION
                INTERFACE_INCLUDE_DIRECTORIES
                INTERFACE_LINK_LIBRARIES
                )
    endforeach()

endfunction()
