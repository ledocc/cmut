include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__parse_version.cmake)



function(cmut__target__set_library_version target version)

    cmut__utils__parse_version(${version} major minor patch)

    set_target_properties(${target}
        PROPERTIES
            VERSION                           ${version}
            SOVERSION                         ${major}
            INTERFACE_${target}_MAJOR_VERSION ${major}
            COMPATIBLE_INTERFACE_STRING       ${target}_MAJOR_VERSION
        )

endfunction()
