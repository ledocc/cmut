
## cmut__qt5__create_translations_file_target( target
##     QT_MODULES Core Multimedia
##     LANGUAGES fr en
##     OUTPUT_FILE_PREFIX path/to/dir/translate_file_prefix
## )
##
## cmut__qt5__create_translations_file_target create custom target to call cmut__qt5__create_translations_file function.
##   cf cmut__qt5__create_translations_file for parameters
##


set(__cmut__qt5__create_translations_file_target__input_script "${CMAKE_CURRENT_LIST_DIR}/cmut__qt5__create_translations_file.cmake.in")


function( cmut__qt5__create_translations_file_target target )

    cmut__qt5__get_qmake_property( bin_dir INSTALL_BINS )
    if ( NOT TARGET Qt5::lconvert )
        cmut_error( "[cmut][qt5][create_translations_file] : neither Qt5::lconvert target and QT5_LCONVERT_CMD are defined." )
        return()
    endif()
    get_target_property(QT5_LCONVERT_CMD Qt5::lconvert IMPORTED_LOCATION)

    set(script_file "${CMAKE_CURRENT_BINARY_DIR}/cmut/qt5/cmut__qt5__create_translations_file.cmake")

    cmut__qt5__create_translations_file__parse_argument( cmut__qt5__create_translations_file_target "${ARGN}")


    configure_file(
        "${__cmut__qt5__create_translations_file_target__input_script}"
        "${script_file}"
        @ONLY
        )

    add_custom_target(${target} ALL
        "${CMAKE_COMMAND}" -P "${script_file}"
        BYPRODUCTS "${ARG_OUTPUT_FILE_PREFIX}-done"
        COMMENT "Create Qt translations files"
    )


endfunction()
