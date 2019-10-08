
function( cmut__lang__function__init_param function_name )

    cmake_parse_arguments( __cmut__lang__function__init_param__ARG "SKIP_UNPARSED" "" "" ${ARGN} )

    cmut__lang__set_in_parent_scope( __cmut__lang__function__function_name ${function_name} )
    cmut__lang__set_in_parent_scope( __cmut__lang__function__arg_prefix ARG)
    cmut__lang__set_in_parent_scope( __cmut__lang__function__skip_unparsed __cmut__lang__function__init_param__ARG_SKIP_UNPARSED)

endfunction()

function( cmut__lang__function__add_option )

    list(APPEND __cmut__lang__function__option_list ${ARGN} )
    cmut__lang__forward_in_parent_scope( __cmut__lang__function__option_list )

endfunction()

function( cmut__lang__function__add_exclusive_option name )

    cmut__lang__function__add_option( ${ARGN} )

    list(APPEND __cmut__lang__function__exclusive_option_list ${name} )
    cmut__lang__forward_in_parent_scope( __cmut__lang__function__exclusive_option_list )

    list(APPEND __cmut__lang__function__exclusive_option_list__${name} ${ARGN} )
    cmut__lang__forward_in_parent_scope( __cmut__lang__function__exclusive_option_list__${name} )

endfunction()

function( cmut__lang__function__add_param param_name )

    cmake_parse_arguments( __cmut__lang__function__add_param__ARG "" "DEFAULT" "" ${ARGN} )

    if(DEFINED __cmut__lang__function__add_param__ARG_DEFAULT)
        cmut__lang__set_in_parent_scope(
            __cmut__lang__function__param_default__${param_name}
            "${__cmut__lang__function__add_param__ARG_DEFAULT}")
    endif()

    list(APPEND __cmut__lang__function__param_list ${param_name} )
    cmut__lang__forward_in_parent_scope( __cmut__lang__function__param_list )

endfunction()

function( cmut__lang__function__add_multi_param multi_param_name )

    list(APPEND __cmut__lang__function__multi_param_list ${multi_param_name} )
    cmut__lang__forward_in_parent_scope( __cmut__lang__function__multi_param_list )

endfunction()

macro( cmut__lang__function__parse_arguments )

    cmake_parse_arguments(
        ${__cmut__lang__function__arg_prefix}
        "${__cmut__lang__function__option_list}"
        "${__cmut__lang__function__param_list}"
        "${__cmut__lang__function__multi_param_list}"
        ${ARGN}
        )

    if(CMUT__LANG__FUNCTION__PARSE_ARGUMENTS__DEBUG)
        cmut_debug("[cmut][lang][function][parse_arguments]: in function \"__cmut__lang__function__function_name\": arguments parsed :")
        foreach(v ${__cmut__lang__function__option_list})
            cmut_debug("-- ${__cmut__lang__function__arg_prefix}_${v} = ${${__cmut__lang__function__arg_prefix}_${v}}")
        endforeach()
        foreach(v ${__cmut__lang__function__param_list})
            cmut_debug("-- ${__cmut__lang__function__arg_prefix}_${v} = ${${__cmut__lang__function__arg_prefix}_${v}}")
        endforeach()
        foreach(v ${__cmut__lang__function__multi_param_list})
            cmut_debug("-- ${__cmut__lang__function__arg_prefix}_${v} = ${${__cmut__lang__function__arg_prefix}_${v}}")
        endforeach()
    endif()

    foreach(param IN LISTS __cmut__lang__function__param_list)
        if(DEFINED __cmut__lang__function__param_default__${param})
            if(NOT DEFINED ${__cmut__lang__function__arg_prefix}_${param})
                set( ${__cmut__lang__function__arg_prefix}_${param} "${__cmut__lang__function__param_default__${param}}" )
            endif()
        endif()
    endforeach()



    if( ${__cmut__lang__function__exclusive_option_list} )
        foreach( name IN LISTS __cmut__lang__function__exclusive_option_list )
            foreach( option IN LISTS __cmut__lang__function__exclusive_option_list__${name} )
                if( DEFINED ARG_${option} )
                    if( NOT__cmut__lang__function__exclusive_option_defined__${name} )
                        set( __cmut__lang__function__exclusive_option_defined__${name} )
                    else()
                        cmut__log__error( $(__cmut__lang__function__function_name) "exclusive option \"${__cmut__lang__function__exclusive_option_list__${name}}\" define multiple times." )
                    endif()
                endif()
            endforeach()
        endforeach()
    endif()

    if( ${__cmut__lang__function__arg_prefix}_UNPARSED_ARGUMENTS AND NOT __cmut__lang__function__skip_unparsed )

        string(APPEND message "in function ${__cmut__lang__function__function_name}\n")
        string(APPEND message "invalid argument(s): ${${__cmut__lang__function__arg_prefix}_UNPARSED_ARGUMENTS}\n")
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

        cmut_fatal("[cmut][lang][function][parse_arguments]: ${message}" )

    endif()

endmacro()
