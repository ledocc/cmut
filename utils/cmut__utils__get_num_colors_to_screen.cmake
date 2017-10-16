include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()

include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__is_running_in_terminal.cmake)


find_program(TPUT_COMMAND tput)



function(cmut__utils__get_num_colors_to_screen result)

    cmut__utils__is_running_in_terminal(__test_terminal)
    if(NOT __test_terminal)
        set(${result} 1 PARENT_SCOPE)
        return()
    endif()

    if(NOT TPUT_COMMAND)
        set(${result} 1 PARENT_SCOPE)
        return()
    endif()
    
    
    # check if file descriptor 1 is open on a terminal
    execute_process(
        COMMAND ${TPUT_COMMAND} colors
        OUTPUT_VARIABLE __result
        )
    set(${result} ${__result} PARENT_SCOPE)

endfunction()

function(cmut__utils__tput result)

    if(NOT TPUT_COMMAND)
        message(FATAL_ERROR "cmut__utils__tput : TPUT_COMMAND not defined. abort")
        return()
    endif()
    
    
    # check if file descriptor 1 is open on a terminal
    execute_process(
        COMMAND ${TPUT_COMMAND} ${ARGN}
        OUTPUT_VARIABLE __result
        )
    set(${result} ${__result} PARENT_SCOPE)

endfunction()


