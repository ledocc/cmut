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

        get_target_property(targetImported ${target} IMPORTED)
        if(targetImported AND NOT (targetType STREQUAL "INTERFACE_LIBRARY"))
            string(TOUPPER ${CMAKE_BUILD_TYPE} BUILD_TYPE)
            list(APPEND targetPropertiesToPrint
                IMPORTED_LINK_DEPENDENT_LIBRARIES
                IMPORTED_LINK_DEPENDENT_LIBRARIES_${BUILD_TYPE}
                IMPORTED_LINK_INTERFACE_LANGUAGES
                IMPORTED_LINK_INTERFACE_LANGUAGES_${BUILD_TYPE}
                IMPORTED_LOCATION
                IMPORTED_LOCATION_${BUILD_TYPE}
                IMPORTED_NO_SONAME
                IMPORTED_NO_SONAME_${BUILD_TYPE}
                )
        endif()

        cmake_print_properties(
            TARGETS
                ${target}
            PROPERTIES ${targetPropertiesToPrint}
        )
    endforeach()

endfunction()
