
function( cmut__export__get_version_file_path result )

    cmut__export__get_config_directory( directory )
    cmut__lang__return_value( "${directory}/${PROJECT_NAME}ConfigVersion.cmake" )

endfunction()
