include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()


include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__parse_arguments.cmake)


function(cmut__utils__find_program program_name)

    cmut__utils__parse_arguments(
        cmut__utils__find_program
        "ARG"
        "REQUIRED"
        ""
        ""
        "${ARGN}"
    )


    string(TOUPPER ${program_name} cmd)
    string(APPEND cmd_var_name ${cmd} _CMD)

    #workaround : if() command fail to test variable stored in cmd_var_name, so create a variable for that
    set( find_program_result "${${cmd_var_name}}" )
    if( find_program_result )
        cmut_debug( "[cmut][utils][find_program] - (${program_name}) : already done : ${cmd_var_name}=${${cmd_var_name}}" )
        return()
    endif()

    find_program(${cmd_var_name} "${program_name}")
    mark_as_advanced(${cmd_var_name})

    set( find_program_result "${${cmd_var_name}}" )
    if( ARG_REQUIRED AND ( NOT find_program_result ))
        cmut_fatal("[cmut][utils][find_program] - \"${program_name}\" required but not found.")
        return()
    endif()

endfunction()
