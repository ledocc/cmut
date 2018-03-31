

include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__parse_arguments.cmake)


function(cmut__utils__execute_process)

    cmut__utils__parse_arguments(
        cmut__utils__execute_process
        ARG
        "FATAL;PRINT_LOG_ON_ERROR"
        "WORKING_DIRECTORY;LOG_FILE;RESULT_VARIABLE"
        "COMMAND"
        ${ARGN}
        )

    if(ARG_COMMAND)
        set(execute_process_args COMMAND ${ARG_COMMAND})
    endif()

    if(ARG_WORKING_DIRECTORY)
        list(APPEND execute_process_args WORKING_DIRECTORY ${ARG_WORKING_DIRECTORY})
    endif()

    if(ARG_LOG_FILE)
        list(APPEND execute_process_args OUTPUT_FILE "${ARG_LOG_FILE}-out.log")
        list(APPEND execute_process_args ERROR_FILE "${ARG_LOG_FILE}-err.log")
    else()
        list(APPEND execute_process_args OUTPUT_VARIABLE output_var)
        list(APPEND execute_process_args ERROR_VARIABLE error_var)

    endif()



    execute_process(
        ${execute_process_args}
        RESULT_VARIABLE result
        )



    if(result)

        set(msg "\nCommand failed: ${result}\n")
        foreach(arg IN LISTS ARG_COMMAND)
            set(msg "${msg} '${arg}'")
        endforeach()
        set(msg "${msg}\n")

        if( (NOT ARG_LOG_FILE) OR ARG_PRINT_LOG_ON_ERROR )
            if(ARG_LOG_FILE)
                file(READ "${ARG_LOG_FILE}-out.log" output_var)
                file(READ "${ARG_LOG_FILE}-err.log" error_var)
            endif()
            set(msg "${msg}output :\n${output_var}\n")
            set(msg "${msg}error  :\n${error_var}\n")
        else()
            set(msg "${msg}See also\n${ARG_LOG_FILE}-*.log")
        endif()
        cmut_info("${msg}")


        if(ARG_FATAL)
            cmut_fatal("execute_process failed.")
        endif()

    endif()

    if(ARG_RESULT_VARIABLE)
        set(${ARG_RESULT_VARIABLE} ${result} PARENT_SCOPE)
    endif()

endfunction()
