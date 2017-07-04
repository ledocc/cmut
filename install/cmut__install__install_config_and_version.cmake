include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include(${CMAKE_CURRENT_LIST_DIR}/cmut__install__define_variables.cmake)


set(config_in_filepath "${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in")


# cmut__install__install_config_and_version :
# - generate and install <project name>Config.cmake
# - generate and install <project name>ConfigVersion.cmake
function(cmut__install__install_config_and_version)

    __cmut__install__define_variables()


    include(CMakePackageConfigHelpers)

    # generate ConfigVersion file
    write_basic_package_version_file(
        "${cmut__install__version_config}" COMPATIBILITY SameMajorVersion
    )


    # generate Config file
    configure_package_config_file(
        "${config_in_filepath}"
        "${cmut__install__project_config}"
        INSTALL_DESTINATION "${cmut__install__config_dir}"
    )

    # install Config and VersionConfig files
    install(
        FILES       "${CMAKE_CURRENT_BINARY_DIR}/${cmut__install__project_config}" "${CMAKE_CURRENT_BINARY_DIR}/${cmut__install__version_config}"
        DESTINATION "${cmut__install__config_dir}"
        COMPONENT    devel
    )

    # register the project build tree in "cmake's User Package Registry"
    if(CMUT__CONFIG__DEVELOPER_MODE)
        set(CMAKE_EXPORT_NO_PACKAGE_REGISTRY OFF)
        export(PACKAGE ${PROJECT_NAME})
    endif()


endfunction()
