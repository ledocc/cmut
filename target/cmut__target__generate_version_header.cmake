include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()


function(cmut__target__generate_version_header target version_h_in)

    set(version_h_path ${target}/version.h)

    configure_file("${version_h_in}" "include/${version_h_path}")

    cmut_info("    configure_file(\"${version_h_in}\" \"include/${version_h_path}\")")

    set_target_properties(${target} PROPERTIES CMUT__TARGET__VERSION_HEADER "${version_h_path}")

    target_sources(
        ${target}
        PUBLIC
            "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include/${version_h_path}>"
    )

    target_include_directories(
        ${target}
        PUBLIC
            "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>"
    )

endfunction()
