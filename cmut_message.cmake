include(${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



set(ENV{__cmut_message_count} 0)
function(cmut_message status severity message)

    string(TIMESTAMP timestamp)
    message(${status} "[cmut] [${timestamp}] $ENV{__cmut_message_count}  <${severity}> : ${message}")

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
