

set(__CMUT__EXPORT__CONFIG_IN "${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in")

function( cmut__export__config )


    cmut__project__get_components( components )
    set( __CMUT__EXPORT__CONFIG__SUPPORTED_COMPONENT "set( ${PROJECT_NAME}_supported_components ${components} )" )

    foreach( component IN LISTS components )

        get_target_property(dependencies ${component} INTERFACE_LINK_LIBRARIES)
        unset( internal_dependencies )
        foreach(dependency IN LISTS dependencies)

            if(NOT TARGET ${dependency})
                continue()
            endif()

            get_target_property(is_imported ${dependency} IMPORTED)
            if( NOT is_imported )
                list( APPEND internal_dependencies ${dependency})
            endif()

        endforeach()


        if(DEFINED internal_dependencies)
            string( APPEND __CMUT__EXPORT__CONFIG__COMPONENT_DEPENDENCIES
                "\nset( ${component}_dependencies ${internal_dependencies} )")
        endif()

    endforeach()


    include( CMakePackageConfigHelpers )

    cmut__export__get_config_directory( config_directory )
    cmut__export__get_config_file_path( config_file_path )
    configure_package_config_file(
        "${__CMUT__EXPORT__CONFIG_IN}"
        "${config_file_path}"
        INSTALL_DESTINATION "${config_directory}"
    )

endfunction()
