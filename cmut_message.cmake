include(${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include(${CMAKE_CURRENT_LIST_DIR}//cmut_color_message.cmake)



set(ENV{__cmut_message_count} 0)
function(cmut_message status severity message)

    if(${ARGC} GREATER 3)
        set(color_message ${ARGV3})
        set(reset_color_message ${cmut_color_message_ColorReset})
    else()
        set(color_message "")
        set(reset_color_message "")
    endif()

    
    string(TIMESTAMP timestamp)

    set(__message
"${cmut_color_message_BoldBlue} [cmut] ${cmut_color_message_ColorReset} \
[${timestamp}] $ENV{__cmut_message_count}  ${cmut_color_message_BoldBlue}<${severity}>${cmut_color_message_ColorReset} : \
${color_message}${message}${reset_color_message}"
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
    cmut_message(STATUS "info" "${message}" ${cmut_color_message_Green})
endfunction()

function(cmut_warn message)
    cmut_message(WARNING "error" "${message}" ${cmut_color_message_Red})
endfunction()

function(cmut_error message)
    cmut_message(SEND_ERROR "error" "${message}" ${cmut_color_message_BoldRed})
endfunction()

function(cmut_fatal message)
    cmut_message(FATAL_ERROR "fatal" "${message}" ${cmut_color_message_BoldRed})
endfunction()
