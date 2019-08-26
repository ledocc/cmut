

# cmut__install__config_dependencies_directory( dependencies_directory )
#     - call cmut__export__dependencies_directory( dependencies_directory )
#     - install exported dependencies directory


function( cmut__install__config_dependencies_directory dependencies_directory)

    cmut__export__dependencies_directory( "${dependencies_directory}" )
    cmut__export__get_dependencies_directory( output_dir )

    install(
            DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${output_dir}/"
            DESTINATION "${output_dir}"
            )

endfunction()
