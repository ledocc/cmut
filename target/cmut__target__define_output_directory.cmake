

function( cmut__target__define_output_directory target )

    cmut__utils__parse_arguments(
        cmut__target__define_output_directory
        ARG
        ""
        "PREFIX"
        ""
        ${ARGN}
        )

    cmut__utils__set_default_argument( ARG_PREFIX "${PROJECT_BINARY_DIR}" )



    if(APPLE)
        set( TARGET_RUNTIME_OUTPUT_DIRECTORY "${ARG_PREFIX}" )
    else()
        set( TARGET_RUNTIME_OUTPUT_DIRECTORY "${ARG_PREFIX}/bin")
    endif()

    if(WIN32)
        set(TARGET_LIBRARY_OUTPUT_DIRECTORY "${ARG_PREFIX}/bin")
    else()
        set(TARGET_LIBRARY_OUTPUT_DIRECTORY "${ARG_PREFIX}/lib")
    endif()

    set(TARGET_ARCHIVE_OUTPUT_DIRECTORY "${ARG_PREFIX}/lib")



    set_target_properties(
        ${target}
        PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY "${TARGET_RUNTIME_OUTPUT_DIRECTORY}"
            LIBRARY_OUTPUT_DIRECTORY "${TARGET_LIBRARY_OUTPUT_DIRECTORY}"
            ARCHIVE_OUTPUT_DIRECTORY "${TARGET_ARCHIVE_OUTPUT_DIRECTORY}"
        )

endfunction()
