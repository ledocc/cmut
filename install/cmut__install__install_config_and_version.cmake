include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include(${CMAKE_CURRENT_LIST_DIR}/cmut__install__define_variables.cmake)


set(config_in_filepath "${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in")


# cmut__install__install_config_and_version :
# - generate and install <project name>Config.cmake
# - generate and install <project name>ConfigVersion.cmake
function(cmut__install__install_config_and_version)

    __cmut__install__define_variables()

    # generate Config file
    cmut__export__config()
    cmut__export__version()

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
