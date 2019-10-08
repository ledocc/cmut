

function( cmut__export__version )

    cmut__lang__function__init_param( cmut__export__version )
    cmut__lang__function__add_param( COMPATIBILITY DEFAULT SameMajorVersion )
    cmut__lang__function__parse_arguments( ${ARGN} )


    include( CMakePackageConfigHelpers )

    cmut__export__get_version_file_path( version_file_path )
    write_basic_package_version_file( "${version_file_path}"
        COMPATIBILITY ${ARG_COMPATIBILITY}
        )

endfunction()
