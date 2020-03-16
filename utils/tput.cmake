include_guard( GLOBAL )
include("${CMAKE_CURRENT_LIST_DIR}/../lang/return.cmake")

function(cmut__utils__tput result default)

    find_program(TPUT_COMMAND tput)

    if(NOT TPUT_COMMAND)
        cmut__lang__return_value( ${default} )
        return()
    endif()

    execute_process(
        COMMAND ${TPUT_COMMAND} ${ARGN}
        STATUS_VARIABLE tput_status
        OUTPUT_VARIABLE tput_output
        ERROR_QUIET
        )

    if (tput_status)
        cmut__lang__return_value( ${default} )
    else()
        cmut__lang__return( tput_output )
    endif()

endfunction()
