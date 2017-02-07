include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()


include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__parse_arguments.cmake)

function(cmut__utils__find_program program_name)
    cmut_debug("cmut__utils__find_program(${program_name}) : begin")

    cmut__utils__parse_arguments(cmut__utils__find_program "__" "REQUIRED" "" "")


    string(TOUPPER ${program_name} cmd)
    string(APPEND cmd_var_name ${cmd} _CMD)


    if(DEFINED ${cmd_var_name})
        cmut_debug("cmut__utils__find_program(${program_name}) : already done : ${cmd_var_name}=${${cmd_var_name}}")
        return()
    endif()

    find_program(${cmd_var_name} "${program_name}")
    mark_as_advanced(${cmd_var_name})

    if(__REQUIRED AND (NOT ${cmd_var_name}))
        cmut_error("${program__name} not found.")
	return()
    endif()

    cmut_debug("cmut__utils__find_program(${program_name}) : end")
endfunction()
