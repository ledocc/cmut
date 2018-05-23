

set(CMUT__QT5__INSTALL_QT_CONF__QT_CONF_FILE "${CMAKE_CURRENT_LIST_DIR}/qt.conf")

function(cmut__qt5__install_qt_conf)

    cmut__utils__parse_arguments(
        cmut__qt5__install_qt_conf
        ARG
        ""
        "DESTINATION;COMPONENT"
        ""
        ${ARGN}
        )

    if(NOT DEFINED ARG_DESTINATION)
        cmut_debug("[cmut][qt5][install_qt_conf] - DESTINATION is required.")
    endif()

    install(
        FILES ${CMUT__QT5__INSTALL_QT_CONF__QT_CONF_FILE}
        DESTINATION "${ARG_DESTINATION}"
        COMPONENT "${ARG_COMPONENT}"
        )


endfunction()
