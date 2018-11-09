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

    if(CMUT__UTILS__PARSE_ARGUMENT__DEBUG)
        cmut_debug("${function_name} arguments parsed :")
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



macro(cmut__utils__set_default_argument arg value)

    if(NOT DEFINED ${arg})
        set(${arg} "${value}")
    endif()

endmacro()

macro(cmut__utils__test_required_argument arg message)

    if(NOT DEFINED ${arg})
        cmut_fatal(${message})
    endif()

endmacro()
