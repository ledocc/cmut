

function( cmut__utils__get_version_from_file result version_file_path )

    if( NOT EXISTS "${version_file_path}" )
        cmut_fatal( "[cmut][utils][get_version_from_file] ${version_file_path} : no such file." )
    endif()

    file( STRINGS "${version_file_path}" version LIMIT_COUNT 1 )

    cmut__lang__return( version )

endfunction()
