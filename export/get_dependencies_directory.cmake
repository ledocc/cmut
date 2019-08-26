
function( cmut__export__get_dependencies_directory result )

    cmut__export__get_config_directory( config_directory )
    cmut__lang__return_value( "${config_directory}/dependencies" )

endfunction()
