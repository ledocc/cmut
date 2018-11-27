

function(cmut__project__set_version version_)

    __cmut__utils__set_version(${PROJECT_NAME} ${version_} cmut__project__set_version)

endfunction()


function(cmut__project__set_version_from_file file_path_)

    if( NOT EXISTS "${file_path_}" )
        cmut_fatal( "[cmut][project][set_version_from_file] ${file_path_} : no such file" )
    endif()

    file( STRINGS "${file_path_}" version LIMIT_COUNT 1 )

    __cmut__utils__set_version( ${PROJECT_NAME} ${version} cmut__project__set_version_from_file )

endfunction()
