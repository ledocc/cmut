include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__parse_version.cmake)



function(cmut__target__set_library_version target version)


    cmut__utils__parse_version(__cmut__lib ${version})


    get_target_property(library_type ${target} TYPE)
    if(NOT ${library_type} STREQUAL "INTERFACE_LIBRARY")

        set_target_properties(${target}
        PROPERTIES
            VERSION                           ${version}
            SOVERSION                         ${__cmut__lib_VERSION_MAJOR}
        )

    endif()

    set_target_properties(${target}
        PROPERTIES
            INTERFACE_${target}_MAJOR_VERSION ${__cmut__lib_VERSION_MAJOR}
            COMPATIBLE_INTERFACE_STRING       ${target}_MAJOR_VERSION
        )

endfunction()
