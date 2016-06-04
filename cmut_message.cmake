if(NOT DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)
set(${CMAKE_CURRENT_LIST_FILE}_include "1")
    


set(ENV{__cmut_message_count} 0)
function(cmut_message status severity message)
    
    string(TIMESTAMP timestamp)        
    message(${status} "cmut [${timestamp}] $ENV{__cmut_message_count}  <${severity}> : ${message}")

    math(EXPR result "$ENV{__cmut_message_count} + 1")
    set(ENV{__cmut_message_count} ${result})

endfunction()

function(cmut_debug message)
    if(CMUT_DEBUG)
        cmut_message(STATUS "debug" "${message}")
    endif()
endfunction()

function(cmut_info message)
    cmut_message(STATUS "info" "${message}")
endfunction()

function(cmut_warn message)
    cmut_message(WARNING "error" "${message}")
endfunction()

function(cmut_error message)
    cmut_message(SEND_ERROR "error" "${message}")
endfunction()

function(cmut_fatal message)
    cmut_message(FATAL_ERROR "fatal" "${message}")
endfunction()



endif(NOT DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)

