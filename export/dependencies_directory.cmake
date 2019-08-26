

function(cmut__export__dependencies_directory dependencies_directory )

    if( NOT IS_ABSOLUTE "${dependencies_directory}" )
        set( dependencies_directory "${CMAKE_CURRENT_LIST_DIR}/${dependencies_directory}" )
    endif()

    file( GLOB_RECURSE files
          LIST_DIRECTORIES false
          RELATIVE "${dependencies_directory}"
          "${dependencies_directory}/*"
        )

    cmut__export__get_dependencies_directory( output_dir )

    foreach( file IN LISTS files )
        configure_file( "${dependencies_directory}/${file}" "${output_dir}/${file}" COPYONLY )
    endforeach()

    configure_file( "${CMUT_ROOT}/dependency/cmut__dependency__add.cmake"  "${output_dir}/cmut__dependency__add.cmake"  COPYONLY )
    configure_file( "${CMUT_ROOT}/dependency/cmut__dependency__find.cmake" "${output_dir}/cmut__dependency__find.cmake" COPYONLY )

endfunction()
