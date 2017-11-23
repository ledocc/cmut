

function( cmut__build__define_output_dir )

    set(base_dir ${PROJECT_BINARY_DIR})
    if(${ARGC} GREATER 0)
        set(base_dir ${ARGV0})
    endif()


    if(APPLE)
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${base_dir} PARENT_SCOPE)
    else()
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${base_dir}/bin PARENT_SCOPE)
    endif()

    if(WIN32)
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${base_dir}/bin PARENT_SCOPE)
    else()
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${base_dir}/lib PARENT_SCOPE)
    endif()
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${base_dir}/lib PARENT_SCOPE)


    cmut_info("[cmut][build] : runtime output dir : ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
    cmut_info("[cmut][build] : library output dir : ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
    cmut_info("[cmut][build] : archive output dir : ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}")

endfunction()
