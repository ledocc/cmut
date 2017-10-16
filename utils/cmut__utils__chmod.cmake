include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()


include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__find_program.cmake)


function(cmut__utils__chmod filename)

    cmut__utils__find_program(chmod)

    execute_process(
        COMMAND "${CHMOD_CMD}" ${ARGN} ${filename}
        RESULT_VARIABLE cmd_result
    )

    if(NOT cmd_result EQUAL 0)
        cmut_error("${CHMOD_CMD} ${ARGN} failed")
    endif()

endfunction()
