include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/parse_arguments.cmake)



function(__cmut__util__test_and_log_execute_process_error result__ )

    if(${result__})
        set(msg "Command failed (${${result__}}):\n")
        foreach(arg ${ARGV})
            set(msg "${msg} '${arg}'")
        endforeach()
        cmut_fatal("${msg}")
    endif()
    
endfunction()

function(cmut__util__execute_process)

    cmut__util__parse_arguments__m(cmut__util__execute_process
        exec
        ""
        ""
        "COMMAND;WORKING_DIRECTORY"
        ${ARGN}
        )


    cmut_info("Configuration command : ${exec_COMMAND}")
    execute_process(
        COMMAND ${exec_COMMAND}
        WORKING_DIRECTORY ${exec_WORKING_DIRECTORY}
        RESULT_VARIABLE result
        )
    __cmut__util__test_and_log_execute_process_error(result ${exec_COMMAND})
    
endfunction()
