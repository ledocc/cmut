include(${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include(${CMAKE_CURRENT_LIST_DIR}/cmut_color_message.cmake)



set(cmut_message_cmut_color ${cmut_color_message_Bold}${cmut_color_message_Blue})
set(cmut_message_info_color ${cmut_color_message_Green})
set(cmut_message_info_message_color ${cmut_message_info_color})
set(cmut_message_warn_color ${cmut_color_message_Red})
set(cmut_message_warn_message_color ${cmut_message_warn_color})
set(cmut_message_error_color ${cmut_color_message_Bold}${cmut_message_warn_color})
set(cmut_message_error_message_color ${cmut_message_error_color})
set(cmut_message_fatal_color ${cmut_color_message_Blink}${cmut_message_error_color})
set(cmut_message_fatal_message_color ${cmut_message_error_color})



set(ENV{__cmut_message_count} 0)
function(cmut_message status severity message)

    string(TIMESTAMP timestamp)

    set(__message
"\
${cmut_message_cmut_color}[cmut] ${cmut_color_message_Reset} \
[${timestamp}] $ENV{__cmut_message_count} \
${cmut_message_${severity}_color}<${severity}>${cmut_color_message_Reset} : \
${cmut_message_${severity}_message_color}${message}${cmut_color_message_Reset}"
        )

    message(${status} "${__message}")

    math(EXPR result "$ENV{__cmut_message_count} + 1")
    set(ENV{__cmut_message_count} ${result})

endfunction()



function(cmut_debug message)
    if(CMUT_DEBUG)
        cmut_message(STATUS "debug" "${message}" )
    endif()
endfunction()

function(cmut_info message)
    cmut_message(STATUS "info" "${message}")
endfunction()

function(cmut_warn message)
    cmut_message(WARNING "warn" "\n${message}")
endfunction()

function(cmut_error message)
    cmut_message(SEND_ERROR "error" "\n${message}")
endfunction()

function(cmut_fatal message)
    cmut_message(FATAL_ERROR "fatal" "\n${message}")
endfunction()
