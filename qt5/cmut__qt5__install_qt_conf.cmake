

function(cmut__qt5__install_qt_conf)

    cmut__utils__parse_arguments(
        cmut__qt5__install_qt_conf
        ARG
        ""
        "QT_CONF_FILE;DESTINATION;COMPONENT"
        ""
        ${ARGN}
        )

    if(NOT DEFINED ARG_QT_CONF_FILE)
        cmut_error("[cmut][qt5][install_qt_conf] - QT_CONF_FILE is required.")
    endif()

    if(NOT DEFINED ARG_DESTINATION)
        cmut_error("[cmut][qt5][install_qt_conf] - DESTINATION is required.")
    endif()

    install(
        FILES ${QT_CONF_FILE}
        DESTINATION "${ARG_DESTINATION}"
        COMPONENT "${ARG_COMPONENT}"
        )


endfunction()
