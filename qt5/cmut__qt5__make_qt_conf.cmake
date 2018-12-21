

function(cmut__qt5__make_qt_conf)

    cmut__utils__parse_arguments(
        cmut__qt5__make_qt_conf
        ARG
        ""
        "OUTPUT_FILE;PREFIX;PLUGINS;QML2IMPORTS;TRANSLATIONS"
        ""
        ${ARGN}
        )

    if(NOT DEFINED ARG_OUTPUT_FILE)
        cmut_error("[cmut][qt5][make_qt_conf] - OUTPUT_FILE not defined.")
    endif()

    if(NOT DEFINED ARG_PREFIX)
        if(APPLE)
            set(ARG_PREFIX .)
        else()
            set(ARG_PREFIX ..)
        endif()
        cmut_info("[cmut][qt5][make_qt_conf] - PREFIX not defined. use \"${ARG_PREFIX}\" as default PREFIX.")
    endif()

    file(WRITE  ${ARG_OUTPUT_FILE} "[Paths]\n")
    file(APPEND ${ARG_OUTPUT_FILE} "Prefix = ${ARG_PREFIX}\n")

    if(DEFINED ARG_PLUGINS)
        file(APPEND ${ARG_OUTPUT_FILE} "Plugins = ${ARG_PLUGINS}\n")
    endif()

    if(DEFINED ARG_QML2IMPORTS)
        file(APPEND ${ARG_OUTPUT_FILE} "Qml2Imports = ${ARG_QML2IMPORTS}\n")
    endif()

    if(DEFINED ARG_TRANSLATIONS)
        file(APPEND ${ARG_OUTPUT_FILE} "Translations = ${ARG_TRANSLATIONS}\n")
    endif()

endfunction()