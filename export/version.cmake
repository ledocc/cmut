

function( cmut__export__version )

    include( CMakePackageConfigHelpers )

    cmut__export__get_version_file_path( version_file_path )
    write_basic_package_version_file( "${version_file_path}"
        COMPATIBILITY SameMinorVersion
        )

endfunction()
