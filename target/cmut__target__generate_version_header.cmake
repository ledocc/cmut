
function(cmut__target__generate_version_header target version_h_in)

    cmut__target__get_generated_header_output_directory( output_dir ${target} )
    set(version_h_path "${output_dir}/${target}/version.h")

    configure_file("${version_h_in}" "${version_h_path}")

    set_target_properties(${target} PROPERTIES CMUT__TARGET__VERSION_HEADER "${version_h_path}")

    target_sources(
        ${target}
        PRIVATE
            "${version_h_path}"
    )

    target_include_directories(
        ${target}
        PUBLIC
            "$<BUILD_INTERFACE:${output_dir}>"
    )

endfunction()

function( cmut__target__get_generated_version_header_path result target )

    get_target_property( generated_version_header_path ${target} CMUT__TARGET__VERSION_HEADER )
    cmut__lang__return( generated_version_header_path )

endfunction()
