



## cmut__qt5__create_translations_file(
##     QT_MODULES Core Multimedia
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

macro(cmut__qt5__create_translations_file__parse_argument function_name)

    cmut__utils__parse_arguments(
        ${function_name}
        ARG
        ""
        "OUTPUT_FILE_PREFIX"
        "QT_MODULES;LANGUAGES"
        ${ARGN}
        )

    if(NOT ARG_OUTPUT_FILE_PREFIX)
        cmut_error( "[cmut][qt5][create_translations_file] : OUTPUT_FILE_PREFIX argument required." )
        return()
    endif()

endmacro()

function( cmut__qt5__create_translations_file )

    cmut__qt5__get_qmake_property( translation_dir INSTALL_TRANSLATIONS )
    if( NOT EXISTS "${translation_dir}" )
        cmut_error( "[cmut][qt5][create_translations_file] : invalid QT_INSTALL_TRANSLATIONS directory : \"${translation_dir}\"" )
        return()
    endif()

    if( NOT DEFINED QT5_LCONVERT_CMD )
        if ( NOT TARGET Qt5::lconvert )
            cmut_error( "[cmut][qt5][create_translations_file] : neither Qt5::lconvert target and QT5_LCONVERT_CMD are defined." )
            return()
        endif()
        get_target_property(QT5_LCONVERT_CMD Qt5::lconvert IMPORTED_LOCATION)
    endif()



    cmut__qt5__create_translations_file__parse_argument( cmut__qt5__create_translations_file ${ARGN} )

    set( components )
    foreach( module IN LISTS ARG_QT_MODULES )

        cmut__qt5__get_component_for_module( component ${module} )
        list( APPEND components ${component} )

    endforeach()

    if( NOT components )
        return()
    endif()


    list( REMOVE_DUPLICATES components )
    foreach( language IN LISTS ARG_LANGUAGES )

        set(translations_files)
        foreach( component IN LISTS components )

            set( translations_file "${translation_dir}/${component}_${language}.qm" )
            if( EXISTS "${translations_file}" )
                list( APPEND translations_files "${translations_file}" )
            else()
#                cmut_warn( "[cmut][qt5][create_translations_file] : no translation file found for component \"${component}\" and language \"${language}\"." )
            endif()

        endforeach()

        cmut_info( "[cmut][qt5][create_translations_file] : generate \"${language}\" translations file." )
        cmut__utils__execute_process(
            COMMAND ${QT5_LCONVERT_CMD} -o "${ARG_OUTPUT_FILE_PREFIX}_${language}.qm" "${translations_files}"
            PRINT_LOG_ON_ERROR
        )

    endforeach()

endfunction()
