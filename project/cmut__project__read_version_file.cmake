
function( cmut__project__read_version_file result file_path )

    cmut_deprecated_function(cmut__project__read_version_file cmut__project__set_version_from_file)

    cmut__utils__get_version_from_file( version "${file_path}" )
    set_directory_properties( PROPERTIES CMAKE_CONFIGURE_DEPENDS "${file_path}" )

    cmut__lang__return( version )

endfunction()
