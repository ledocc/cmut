

include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__parse_arguments.cmake)


function(cmut__utils__execute_process)

    cmut__utils__parse_arguments(
        cmut__utils__execute_process
        ARG
        "FATAL"
        "WORKING_DIRECTORY"
        "COMMAND"
        ${ARGN}
        )

    if(ARG_COMMAND)
        set(execute_process_args COMMAND ${ARG_COMMAND})
    endif()

    if(ARG_WORKING_DIRECTORY)
        list(APPEND execute_process_args WORKING_DIRECTORY ${ARG_WORKING_DIRECTORY})
    endif()



    execute_process(
        ${execute_process_args}
        RESULT_VARIABLE result_var
        OUTPUT_VARIABLE output_var
        ERROR_VARIABLE error_var
        )

    if(result_var)
        set(msg "execute_process failed.\ncommand \"${ARG_COMMAND}\" return ${result_var}.\noutput : ${output_var}\nerror  : ${error_var}")

        if(ARG_FATAL)
            cmut_fatal("${msg}")
        else()
            cmut_warn("${msg}")
        endif()
    endif()

endfunction()
