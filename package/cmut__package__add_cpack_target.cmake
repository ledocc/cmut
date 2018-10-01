



function(cmut__package__add_cpack_target targetName )

    cmut__utils__parse_arguments(
        cmut__package__add_cpack_target
        ARG
        ""
        "COMMENT"
        "CPACK_OPTIONS"
        ${ARGN}
        )

    if(NOT DEFINED CMAKE_CPACK_COMMAND)
        get_filename_component(CMAKE_COMMAND_DIRECTORY "${CMAKE_COMMAND}" DIRECTORY)
        find_program(CMAKE_CPACK_COMMAND cpack HINTS "${CMAKE_COMMAND_DIRECTORY}")
        if(NOT CMAKE_CPACK_COMMAND)
            cmut_fatal("cpack executable not found")
        endif()
    endif()


    cmut_info("[cmut][package][add_cpack_target] : create target \"${targetName}\"")
    add_custom_target( ${targetName}
        COMMAND
        ${CMAKE_CPACK_COMMAND} ${ARG_CPACK_OPTIONS}
        COMMENT "${ARG_COMMENT}"
        USES_TERMINAL
        )

endfunction()
