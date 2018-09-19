

## cmut__qt5__create_and_install_translations_file(
##     LANGUAGES fr en
##     OUTPUT_FILE_PREFIX path/to/dir/translate_file_prefix
## )
##
## QT_MODULES : list of module to collect translations files
## LANGUAGES : list of language to collect translations files
## OUTPUT_FILE_PREFIX : path file prefix of output translation file
##
##
## cmut__qt5__create_translations_file use qt's tool "lconvert" to convert
##   translations files of component corresponding to QT_MODULES in one file
##   ${OUTPUT_FILE_PREFIX}_${language}.qm for each language in LANGUAGES parameters
##
##


function(cmut__qt5__create_and_install_translations_file target)

    cmut__utils__parse_arguments(
        cmut__qt5__create_and_install_translations_file
        ARG
        ""
        "OUTPUT_DIR;INSTALL_DIR"
        "LANGUAGES"
        ${ARGN}
        )

    if(NOT ARG_OUTPUT_DIR)
        cmut_error( "[cmut][qt5][create_and_install_translations_file] : OUTPUT_DIR argument required." )
        return()
    endif()

    if(NOT ARG_INSTALL_DIR)
        cmut_error( "[cmut][qt5][create_and_install_translations_file] : INSTALL_DIR argument required." )
        return()
    endif()

    if(NOT ARG_LANGUAGES)
        cmut_error( "[cmut][qt5][create_and_install_translations_file] : LANGUAGES argument required." )
        return()
    endif()



    cmut__qt5__collect_dependencies_recursively( qt_dependencies ${target} )

    cmut__qt5__create_translations_file_target( ${target}_qt_translation
        QT_MODULES ${qt_dependencies}
        LANGUAGES ${ARG_LANGUAGES}
        OUTPUT_FILE_PREFIX "${ARG_OUTPUT_DIR}/${target}_qt"
    )

    cmut__qt5__install_translations_file(
        LANGUAGES ${ARG_LANGUAGES}
        FILE_PREFIX "${ARG_OUTPUT_DIR}/${output_prefix_name}"
        INSTALL_DIR "${ARG_INSTALL_DIR}"
    )

endfunction()
