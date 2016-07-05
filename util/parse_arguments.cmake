include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)


set(CMUT_DEBUG 1)
macro(cmut__util__parse_arguments__m function_name
                                     prefix options
                                     one_value_keywords
                                     multi_value_keywords)
    set(function_name cmut__util__parse_arguments__m)
    string(TOUPPER ${function_name} FUNCTION_NAME)
                                

    cmake_parse_arguments(${prefix}
        "${options}"
        "${one_value_keywords}"
        "${multi_value_keywords}"
        ${ARGN}
        )
    
    if(${FUNCTION_NAME}__DEBUG)
        foreach(v ${options})
            cmut_debug("${prefix}_${v} = ${${prefix}_${v}}")
        endforeach()
        foreach(v ${one_value_keywords})
            cmut_debug("${prefix}_${v} = ${${prefix}_${v}}")
        endforeach()
        foreach(v ${multi_value_keywords})
            cmut_debug("${prefix}_${v} = ${${prefix}_${v}}")
        endforeach()
    endif()
    
    
    if(${prefix}_UNPARSED_ARGUMENTS)
        cmut_fatal("${function_name}: invalid argument(s): ${${prefix}_UNPARSED_ARGUMENTS}" )
    endif()
    
endmacro()
