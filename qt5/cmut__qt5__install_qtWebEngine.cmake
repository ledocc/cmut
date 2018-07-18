


function(cmut__qt5__install_qtWebEngine)

    cmut__utils__parse_arguments(
        cmut__qt5__install_qtWebEngine
        "ARG"
        ""
        "BUILD_TYPE;RESOURCE_DESTINATION;BIN_DESTINATION;LIBEXEC_DESTINATION;COMPONENT"
        "MODULE"
        ${ARGN}
        )

    if(NOT DEFINED ARG_BUILD_TYPE)
        if(NOT CMAKE_BUILD_TYPE STREQUAL "")
            cmut_info("[cmut][qt5][install_qtWebEngine] - BUILD_TYPE not defined. Fallback to CMAKE_BUILD_TYPE \(${CMAKE_BUILD_TYPE}\).")
            set(ARG_BUILD_TYPE ${CMAKE_BUILD_TYPE})
        else()
            cmut_info("[cmut][qt5][install_qtWebEngine] - neither BUILD_TYPE or CMAKE_BUILD_TYPE defined. Use Release instead.")
        endif()

        if((NOT ARG_BUILD_TYPE STREQUAL "Release" ) AND ( NOT ARG_BUILD_TYPE STREQUAL "Debug" ))
            cmut_info("[cmut][qt5][install_qtWebEngine] - BUILD_TYPE not defined on Release or Debug, but required to init QT5_BUILD_TYPE and found Qt5 plugin location. Using \"QT5_BUILD_TYPE=Release\" instead.")
            set(ARG_BUILD_TYPE "Release")
        endif()

        set(QT5_BUILD_TYPE ${CMAKE_BUILD_TYPE})

    endif()

    if(NOT DEFINED ARG_DESTINATION)
        cmut_debug("[cmut][qt5][install_qtWebEngine] - DESTINATION is required.")
    endif()


    cmut__qt5__get_qmake_property(QT5_INSTALL_PREFIX INSTALL_PREFIX)


    cmut_debug("[cmut][qt5][install_qtWebEngine] - begin.")

    # ---------------------------------------------------------------------------------------
    # install qtWebEngine resources
    # ---------------------------------------------------------------------------------------
    if(NOT APPLE)
        install(
            FILES
                ${QT5_INSTALL_PREFIX}/resources/icudtl.dat
                ${QT5_INSTALL_PREFIX}/resources/qtwebengine_resources.pak
                ${QT5_INSTALL_PREFIX}/resources/qtwebengine_resources_100p.pak
                ${QT5_INSTALL_PREFIX}/resources/qtwebengine_resources_200p.pak
            DESTINATION ${ARG_RESOURCE_DESTINATION}
            COMPONENT ${ARG_COMPONENT}
            )
        install(
            DIRECTORY ${QT5_INSTALL_PREFIX}/translations/qtwebengine_locales
            DESTINATION ${ARG_RESOURCE_DESTINATION}/translations
            COMPONENT ${ARG_COMPONENT}
            )
    endif()

    if(MSVC)
        install(
            PROGRAMS ${QT5_INSTALL_PREFIX}/bin/QtWebEngineProcess$<$<CONFIG:Debug>:d>${CMAKE_EXECUTABLE_SUFFIX}
            DESTINATION ${ARG_BIN_DESTINATION}
            COMPONENT ${ARG_COMPONENT}
            )
    elseif(UNIX AND NOT APPLE)
        install(
            PROGRAMS ${QT5_INSTALL_PREFIX}/libexec/QtWebEngineProcess
            DESTINATION ${ARG_LIBEXEC_DESTINATION}
            COMPONENT ${ARG_COMPONENT}
            )
        install(
            FILES ${CMAKE_CURRENT_BINARY_DIR}/qt.conf
            DESTINATION ${ARG_LIBEXEC_DESTINATION}
            COMPONENT ${ARG_COMPONENT}
            )
    endif()

    cmut_debug("[cmut][qt5][install_qtWebEngine] - end.")

endfunction()
