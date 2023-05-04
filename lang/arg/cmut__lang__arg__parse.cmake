
macro(cmut__lang__arg__set_params
        prefix
        options
        one_value_keywords
        multi_value_keywords
)
    set( ${prefix}_options              "${options}" )
    set( ${prefix}_one_value_keywords   "${one_value_keywords}" )
    set( ${prefix}_multi_value_keywords "${multi_value_keywords}" )

endmacro()

macro(cmut__lang__arg__add_params
        prefix
        options
        one_value_keywords
        multi_value_keywords
)
    list( APPEND ${prefix}_options              "${options}" )
    list( APPEND ${prefix}_one_value_keywords   "${one_value_keywords}" )
    list( APPEND ${prefix}_multi_value_keywords "${multi_value_keywords}" )

endmacro()



macro(cmut__lang__arg__parse_defined_options
        function_name
        prefix
        option_prefix
        )
    cmut__lang__arg__parse(
            ${function_name}
            ${prefix}
            "${${option_prefix}_options}"
            "${${option_prefix}_one_value_keywords}"
            "${${option_prefix}_multi_value_keywords}"
        ${ARGN}
    )
endmacro()



macro(cmut__lang__arg__parse
        function_name
        prefix
        options
        one_value_keywords
        multi_value_keywords
        )

    set(log_tag "[cmut][lang][arg][parse]")

    cmake_parse_arguments(
        ${prefix}
        "${options}"
        "${one_value_keywords}"
        "${multi_value_keywords}"
        ${ARGN}
        )

    if(CMUT__LANG__ARG__PARSE__DEBUG)
        cmut_debug("${log_tag} arguments parsed :")
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

        string(APPEND message "in function ${function_name}\n")
        string(APPEND message "invalid argument(s): ${${prefix}_UNPARSED_ARGUMENTS}\n")
        string(APPEND message "available parameters are:\n")
        string(APPEND message "options:\n")
        foreach(v ${options})
            string(APPEND message "  - ${v}\n")
        endforeach()

        string(APPEND message "one_value_keywords:\n")
        foreach(v ${one_value_keywords})
            string(APPEND message "  - ${v}\n")
        endforeach()

        string(APPEND message "multi_value_keywords:\n")
        foreach(v ${multi_value_keywords})
            string(APPEND message "  - ${v}\n")
        endforeach()

        cmut_fatal("${log_tag}: ${message}" )
    endif()

    set( __cmut__lang__arg__current_prefix ${prefix} )

endmacro()