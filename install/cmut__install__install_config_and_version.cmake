
# cmut__install__install_config_and_version :
# - generate and install <project name>Config.cmake
# - generate and install <project name>ConfigVersion.cmake
function(cmut__install__install_config_and_version)

    cmut__lang__function__init_param( cmut__install__install_config_and_version )
    cmut__lang__function__add_param( COMPATIBILITY )
    cmut__lang__function__parse_arguments( ${ARGN} )


    cmut__export__config()

    set(export_version__compatibility)
    if(DEFINED ARG_COMPATIBILITY)
        set(export_version__compatibility COMPATIBILITY ${ARG_COMPATIBILITY} )
    endif()
    cmut__export__version( ${export_version__compatibility} )

    cmut__export__get_config_file_path(config_file_path)
    cmut__export__get_version_file_path(version_file_path)
    cmut__export__get_config_directory( config_directory )
    # install Config and VersionConfig files
   install(
        FILES       "${CMAKE_BINARY_DIR}/${config_file_path}"
                    "${CMAKE_BINARY_DIR}/${version_file_path}"
        DESTINATION "${config_directory}"
        COMPONENT    devel
    )

endfunction()
