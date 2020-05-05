

function(cmut__install__generated_headers target)

    cmut__lang__function__init_param( cmut__install__generated_headers )
    cmut__lang__function__add_param( COMPONENT      DEFAULT devel )
    cmut__lang__function__add_param( DESTINATION    DEFAULT ${cmut__install__include_dir} )
    cmut__lang__function__parse_arguments( ${ARGN} )

    
    cmut__target__get_generated_header_output_directory( generated_header_output_directory ${target} )
    cmut__target__get_generated_forward_header_paths( generated_forward_header_paths ${target} )
    cmut__target__get_generated_export_header_path( generated_export_header_path ${target} )
    cmut__target__get_generated_version_header_path( generated_version_header_path ${target} )

    cmut__install__headers( ${target}
        COMPONENT ${ARG_COMPONENT}
        DIRECTORY_BASE "${generated_header_output_directory}"
        HEADERS
            "${generated_forward_header_paths}"
            "${generated_export_header_path}"
            "${generated_version_header_path}"
    )

endfunction()
