
function( cmut__export__files )

    cmut__export__get_config_directory( destination ${target} )

    foreach(file ${ARGN})
        get_filename_component(filename "${file}" NAME)
        configure_file("${file}" "${PROJECT_BINARY_DIR}/${destination}/${filename}" COPYONLY)
    endforeach()

endfunction()
