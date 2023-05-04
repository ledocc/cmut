
function(cmut__target__generate_export_header target)

    if (ARGC GREATER 1)
        set(export_macro_name "${ARGV2}_export")
        string(TOUPPER "${export_macro_name}" export_macro_name)
    endif()

    if(ARGC GREATER 0)
        set(export_filename "${ARGV1}")
    else()
        string(TOLOWER "${target}" target_lower)
        set(export_filename "${target_lower}_export.h")
    endif()


    cmut__target__get_generated_header_output_directory( output_dir )

    include(GenerateExportHeader)
    if (DEFINED export_macro_name)
        generate_export_header( ${target}
            EXPORT_FILE_NAME "${output_dir}/${export_filename}"
            EXPORT_MACRO_NAME ${export_macro_name}
        )
    else()
        generate_export_header( ${target}
            EXPORT_FILE_NAME "${output_dir}/${export_filename}"
        )
    endif()

    cmut__target__get_property_prefix(prefix ${target})
    set_target_properties( ${target}
        PROPERTIES
            ${prefix}CMUT__TARGET__EXPORT_HEADER "${output_dir}/${export_filename}"
    )

    target_sources( ${target}
        PRIVATE
            "${output_dir}/${export_filename}"
    )
    target_include_directories( ${target}
        PUBLIC
            "$<BUILD_INTERFACE:${output_dir}>"
    )


endfunction()

function( cmut__target__get_generated_export_header_path result target )

    cmut__target__get_property_prefix(prefix ${target})

    get_target_property( generated_export_header_path ${target} ${prefix}CMUT__TARGET__EXPORT_HEADER )
    cmut__lang__return( generated_export_header_path )

endfunction()
