

function( cmut__build__define_output_dir )

    cmut__utils__parse_arguments(
        cmut__build__define_output_dir
        ARG
        ""
        "BASE_DIR"
        ""
        )

    cmut__utils__set_default_argument(ARG_BASE_DIR ${PROJECT_BINARY_DIR})


    if(APPLE)
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${ARG_BASE_DIR} PARENT_SCOPE)
    else()
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${ARG_BASE_DIR}/bin PARENT_SCOPE)
    endif()

    if(WIN32)
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${ARG_BASE_DIR}/bin PARENT_SCOPE)
    else()
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${ARG_BASE_DIR}/lib PARENT_SCOPE)
    endif()
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${ARG_BASE_DIR}/lib PARENT_SCOPE)


    cmut_info("[cmut][build] : runtime output dir : ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
    cmut_info("[cmut][build] : library output dir : ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
    cmut_info("[cmut][build] : archive output dir : ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}")

endfunction()
