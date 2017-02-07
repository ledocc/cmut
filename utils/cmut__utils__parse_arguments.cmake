include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)



macro(cmut__utils__parse_arguments function_name
                                   prefix options
                                   one_value_keywords
                                   multi_value_keywords)

    set(function_name cmut__utils__parse_arguments)


    cmake_parse_arguments(${prefix}
        "${options}"
        "${one_value_keywords}"
        "${multi_value_keywords}"
        ${ARGN}
        )

    if(CMUT_DEBUG)
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
