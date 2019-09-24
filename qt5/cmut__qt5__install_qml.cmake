
include("${CMUT_ROOT}/cmut_is_release_bin.cmake")

function(cmut__qt5__install_qml)

    cmut__utils__parse_arguments(
        cmut__qt5__install_qml
        "ARG"
        ""
        "BUILD_TYPE;DESTINATION;COMPONENT;SOURCE_DIR"
        "MODULE"
        ${ARGN}
        )

    if(NOT DEFINED ARG_BUILD_TYPE)
        if(NOT CMAKE_BUILD_TYPE STREQUAL "")
            cmut_info("[cmut][qt5][install_qml] - BUILD_TYPE not defined. Fallback to CMAKE_BUILD_TYPE \(${CMAKE_BUILD_TYPE}\).")
            set(ARG_BUILD_TYPE ${CMAKE_BUILD_TYPE})
        else()
            cmut_info("[cmut][qt5][install_qml] - neither BUILD_TYPE or CMAKE_BUILD_TYPE defined. Use Release instead.")
        endif()

        if((NOT ARG_BUILD_TYPE STREQUAL "Release" ) AND ( NOT ARG_BUILD_TYPE STREQUAL "Debug" ))
            cmut_info("[cmut][qt5][install_qml] - BUILD_TYPE not defined on Release or Debug, but required to init QT5_BUILD_TYPE and found Qt5 plugin location. Using \"QT5_BUILD_TYPE=Release\" instead.")
            set(ARG_BUILD_TYPE "Release")
        endif()

        set(QT5_BUILD_TYPE ${CMAKE_BUILD_TYPE})
    endif()


    if(NOT DEFINED ARG_DESTINATION)
        cmut_error("[cmut][qt5][install_qml] - DESTINATION is required.")
        return()
    endif()


    if(NOT DEFINED ARG_SOURCE_DIR)
        cmut__qt5__get_qmake_property(ARG_SOURCE_DIR INSTALL_QML)
    endif()


    cmut_debug("[cmut][qt5][install_qml] - begin.")

    foreach(qmlLib ${ARG_MODULE})

        # install file in qml directory except libraries
        install(
            DIRECTORY "${ARG_SOURCE_DIR}/${qmlLib}"
            DESTINATION ${ARG_DESTINATION}
            COMPONENT ${ARG_COMPONENT}
            PATTERN *${CMAKE_SHARED_LIBRARY_SUFFIX} EXCLUDE
            )

        # collect all Qt's qml library
        file(
            GLOB_RECURSE QTQML_LIBS
            RELATIVE ${ARG_SOURCE_DIR}
            ${ARG_SOURCE_DIR}/${qmlLib}/*${CMAKE_SHARED_LIBRARY_SUFFIX}
            )


        # for all qml library
        foreach(lib ${QTQML_LIBS})

            # test if this is a release build
            set(IS_RELEASE_BUILDED 0)
            if(MSVC)
                cmut_is_release_bin(IS_RELEASE_BUILDED "${ARG_SOURCE_DIR}/${lib}")
            elseif(APPLE)
                if(NOT (${lib} MATCHES ".*_debug.dylib"))
                    set(IS_RELEASE_BUILDED 1)
                endif()
            else()
                set(IS_RELEASE_BUILDED 1)
            endif()

            if(NOT ARG_BUILD_TYPE STREQUAL "Debug")
                set(TO_INSTALL ${IS_RELEASE_BUILDED})
            else()
                set(TO_INSTALL $<NOT:${IS_RELEASE_BUILDED}>)
            endif()

            # if qml lib is a release build
            if( TO_INSTALL )

                # get qml lib's directory relative path from qt5 qml install dir
                get_filename_component(dir ${lib} DIRECTORY)

                # install Qt qml in install dir, with the same directory hierarchy as in qt
                install(
                    FILES "${ARG_SOURCE_DIR}/${lib}"
                    DESTINATION "${ARG_DESTINATION}/${dir}"
                    COMPONENT ${ARG_COMPONENT}
                    )
            endif()
        endforeach()
    endforeach()

    cmut_debug("[cmut][qt5][install_qml] - end.")

endfunction()
