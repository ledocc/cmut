include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()


find_program(TEST_COMMAND test)


function(cmut__utils__is_running_in_terminal result)

    if(NOT TEST_COMMAND)
        set(${result} 0)
        return()
    endif()

    # check if file descriptor 1 is open on a terminal
    execute_process(
        COMMAND ${TEST_COMMAND} -t 1
        RESULT_VARIABLE __result
        )

    set(${result} ${__result} PARENT_SCOPE)
    
endfunction()
