
function(cmut__target__generate_version_header target version_h_in)

    set(version_h_path ${target}/version.h)

    configure_file("${version_h_in}" "include/${version_h_path}")

    set_target_properties(${target} PROPERTIES CMUT__TARGET__VERSION_HEADER "${version_h_path}")

    target_sources(
        ${target}
        PRIVATE
            "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include/${version_h_path}>"
    )

    target_include_directories(
        ${target}
        PUBLIC
            "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>"
    )

endfunction()
