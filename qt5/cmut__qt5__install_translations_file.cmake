
## cmut__qt5__install_translations_file(
##     LANGUAGES fr en
##     FILE_PREFIX path/to/translate_file_prefix
##     INSTALL_DIR install directory
## )
##
## LANGUAGES : list of language to collect translations files
## FILE_PREFIX : path file prefix of translation files to install
## INSTALL_DIR : directories relative to ${CMAKE_PREFIX_INSTALL} where install translation file
##
##
## cmut__qt5__create_translations_file use qt's tool "lconvert" to convert
##   translations files of component corresponding to QT_MODULES in one file
##   ${OUTPUT_FILE_PREFIX}_${language}.qm for each language in LANGUAGES parameters
##
##

function( cmut__qt5__install_translations_file )

    cmut__utils__parse_arguments(
        cmut__qt5__install_translations_file
        ARG
        ""
        "FILE_PREFIX;INSTALL_DIR"
        "LANGUAGES"
        ${ARGN}
        )

    if( NOT ARG_FILE_PREFIX )
        cmut_error( "[cmut][qt5][install_translations_file] : FILE_PREFIX argument required." )
        return()
    endif()

    if( NOT ARG_INSTALL_DIR )
        cmut_error( "[cmut][qt5][install_translations_file] : INSTALL_DIR argument required." )
        return()
    endif()



    set( translation_files )
    foreach( language IN LISTS ARG_LANGUAGES )
        list( APPEND translation_files "${ARG_FILE_PREFIX}_${language}.qm" )
    endforeach()

    install(
        FILES
            ${translation_files}
        DESTINATION
            "${ARG_INSTALL_DIR}"
    )

endfunction()
