


function(cmut__qt5__install_plugins)

    cmut__utils__parse_arguments(
        cmut__qt5__install_plugins
        "ARG"
        ""
        "BUILD_TYPE;DESTINATION;COMPONENT"
        "MODULE"
        ${ARGN}
        )

    if(NOT DEFINED ARG_BUILD_TYPE)
        if(NOT CMAKE_BUILD_TYPE STREQUAL "")
            cmut_info("[cmut][qt5][install_plugins] - BUILD_TYPE not defined. Fallback to CMAKE_BUILD_TYPE \(${CMAKE_BUILD_TYPE}\).")
            set(ARG_BUILD_TYPE ${CMAKE_BUILD_TYPE})
        else()
            cmut_info("[cmut][qt5][install_plugins] - neither BUILD_TYPE or CMAKE_BUILD_TYPE defined. Use Release instead.")
            set(ARG_BUILD_TYPE "Release")
        endif()
    endif()

    if((NOT ARG_BUILD_TYPE STREQUAL "Release" ) AND ( NOT ARG_BUILD_TYPE STREQUAL "Debug" ))
        cmut_info("[cmut][qt5][install_plugins] - BUILD_TYPE not defined on Release or Debug, but required to init QT5_BUILD_TYPE and found Qt5 plugin location. Using \"QT5_BUILD_TYPE=Release\" instead.")
        set(ARG_BUILD_TYPE "Release")
    endif()
    set(QT5_BUILD_TYPE ${ARG_BUILD_TYPE})


    if(NOT DEFINED ARG_DESTINATION)
        cmut_debug("[cmut][qt5][install_plugins] - DESTINATION is required.")
    endif()


    cmut__qt5__get_qmake_property(QT5_INSTALL_PLUGINS INSTALL_PLUGINS)

    cmut_debug("[cmut][qt5][install_plugins] - begin.")


    string(TOUPPER "${QT5_BUILD_TYPE}" Configuration)

    foreach(lib ${ARG_MODULE})
        cmut_debug("[cmut][qt5][install_plugins] - plugin for ${lib}.")

        foreach(plugin ${Qt5${lib}_PLUGINS})

            get_target_property(plugin_location "${plugin}" IMPORTED_LOCATION_${Configuration})

            if(NOT plugin_location AND (Configuration STREQUAL "DEBUG"))
                get_target_property(plugin_location ${plugin} IMPORTED_LOCATION_RELEASE)
            endif()

            if(NOT plugin_location)
                cmut_info("[cmut][qt5][install_plugins][${lib}] - no location found for plugin \"${plugin}\". Skipped.")
                continue()
            endif()

            cmut_debug("[cmut][qt5][install_plugins] - ${plugin} location : ${plugin_location}.")
            file(RELATIVE_PATH plugin_location_relative_to_qt5_plugin_dir "${QT5_INSTALL_PLUGINS}" "${plugin_location}")
            get_filename_component(plugin_dir_name ${plugin_location_relative_to_qt5_plugin_dir} DIRECTORY)
            cmut_debug("[cmut][qt5][install_plugins] - ${plugin} install : ${ARG_DESTINATION}/${plugin_dir_name}.")

            install(
                FILES "${plugin_location}"
                DESTINATION "${ARG_DESTINATION}/${plugin_dir_name}"
                COMPONENT ${ARG_COMPONENT}
                )

        endforeach()
    endforeach()

    cmut_debug("[cmut][qt5][install_plugins] - end.")

endfunction()
