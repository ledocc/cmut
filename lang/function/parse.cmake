#set(CMUT__LANG__FUNCTION__DEBUG 1)


macro( cmut__lang__function__get_current_function result )
    if( DEFINED CMAKE_CURRENT_FUNCTION )
        set( ${result} ${CMAKE_CURRENT_FUNCTION} )
    elseif( DEFINED CMUT__LANG__FUNCTION__CURRENT_FUNCTION )
        set( ${result} ${CMUT__LANG__FUNCTION__CURRENT_FUNCTION} )
    else()
        unset( ${result} )
    endif()
endmacro()


macro( cmut__lang__function__set_initialized function_name )
    cmut__lang__set_in_parent_scope( __cmut__lang__function__${function_name}__param_initialized 1 )
endmacro()

function( cmut__lang__function__is_initialized result function_name )
    cmut__lang__return( __cmut__lang__function__${function_name}__param_initialized )
endfunction()

macro( cmut__lang__function__return_if_initialized function_name )
    cmut__lang__function__is_initialized( is_initialized ${function_name} )
    if( is_initialized )
        return()
    endif()
endmacro()






function( cmut__lang__function__init_param function_name )

    cmut__lang__function__return_if_initialized( ${function_name} )
    cmut__lang__set_in_parent_scope( CMUT__LANG__FUNCTION__CURRENT_FUNCTION ${function_name} )

    cmut__log__debug_if( cmut__lang__function__init_param
        "Initialize parameter(s) definition of \"${function_name}\"."
        CMUT__LANG__FUNCTION__DEBUG )


    cmake_parse_arguments( __cmut__lang__function__init_param__ARG "SKIP_UNPARSED" "" "" ${ARGN} )

    cmut__lang__set_in_parent_scope( __cmut__lang__function__function_name ${function_name} )
    cmut__lang__set_in_parent_scope( __cmut__lang__function__arg_prefix ARG)
    cmut__lang__set_in_parent_scope( __cmut__lang__function__skip_unparsed __cmut__lang__function__init_param__ARG_SKIP_UNPARSED)
    cmut__lang__set_in_parent_scope( __cmut__lang__function__option_list "" )
    cmut__lang__set_in_parent_scope( __cmut__lang__function__exclusive_option_list "" )
    cmut__lang__set_in_parent_scope( __cmut__lang__function__param_list "" )
    cmut__lang__set_in_parent_scope( __cmut__lang__function__multi_param_list "" )


    cmut__lang__function__set_initialized( ${function_name} )

endfunction()

macro( cmut__lang__function__auto_init_or_fatal_error )
    cmut__lang__function__get_current_function( current_function_name )
    if( DEFINED current_function_name )
        cmut__lang__function__init_param( ${current_function_name} )
    else()
        cmut__log__fatal( cmut__lang__function__auto_init_or_fatal_error  "You need to define CMAKE_CURRENT_FUNCTION or CMUT__LANG__FUNCTION__CURRENT_FUNCTION to use cmut__lang__function API, or call cmut__lang__function__init_param( <function_name> ) to init cmut__lang__function API.")
        return()
    endif()
endmacro()

macro( cmut__lang__function__add_option )
    cmut__lang__function__auto_init_or_fatal_error()
    cmut__lang__function__add_option__impl( ${ARGV} )
endmacro()

macro( cmut__lang__function__add_param )
    cmut__lang__function__auto_init_or_fatal_error()
    cmut__lang__function__add_param__impl( ${ARGV} )
endmacro()



function( cmut__lang__function__add_option__impl )

    list(APPEND __cmut__lang__function__option_list ${ARGN} )
    cmut__lang__forward_in_parent_scope( __cmut__lang__function__option_list )

    cmut__log__debug_if( cmut__lang__function__add_option
                         "add option(s) \"${ARGN}\"."
                         CMUT__LANG__FUNCTION__DEBUG )

endfunction()

function( cmut__lang__function__add_exclusive_option name )

    cmut__lang__function__add_option( ${ARGN} )

    list(APPEND __cmut__lang__function__exclusive_option_list ${name} )
    cmut__lang__forward_in_parent_scope( __cmut__lang__function__exclusive_option_list )

    list(APPEND __cmut__lang__function__exclusive_option_list__${name} ${ARGN} )
    cmut__lang__forward_in_parent_scope( __cmut__lang__function__exclusive_option_list__${name} )

    cmut__log__debug_if( cmut__lang__function__add_exclusive_option
                         "add exclusive options \"${ARGN}\"."
                         CMUT__LANG__FUNCTION__DEBUG )

endfunction()

function( cmut__lang__function__add_param__impl param_name )

    cmake_parse_arguments( ARG "" "DEFAULT" "" ${ARGN} )

    if(DEFINED ARG_DEFAULT)
        cmut__lang__set_in_parent_scope(
            __cmut__lang__function__param_default__${param_name}
            "${ARG_DEFAULT}")
    endif()

    list(APPEND __cmut__lang__function__param_list ${param_name} )
    cmut__lang__forward_in_parent_scope( __cmut__lang__function__param_list )

    cmut__log__debug_if( cmut__lang__function__add_param
        "add parameter \"${param_name}\", (default:${ARG_DEFAULT})."
        CMUT__LANG__FUNCTION__DEBUG
    )

endfunction()

function( cmut__lang__function__add_multi_param multi_param_name )

    cmake_parse_arguments( ARG "" "DEFAULT" "" ${ARGN} )

    if(DEFINED ARG_DEFAULT)
        cmut__lang__set_in_parent_scope(
            __cmut__lang__function__multi_param_default__${multi_param_name}
            "${ARG_DEFAULT}")
    endif()

    list(APPEND __cmut__lang__function__multi_param_list ${multi_param_name} )
    cmut__lang__forward_in_parent_scope( __cmut__lang__function__multi_param_list )

    cmut__log__debug_if( cmut__lang__function__add_multi_param
        "add multi-values parameter \"${multi_param_name}\", (default:${ARG_DEFAULT})."
        CMUT__LANG__FUNCTION__DEBUG
    )

endfunction()

macro( cmut__lang__function__parse_arguments )

    cmake_parse_arguments(
        ${__cmut__lang__function__arg_prefix}
        "${__cmut__lang__function__option_list}"
        "${__cmut__lang__function__param_list}"
        "${__cmut__lang__function__multi_param_list}"
        ${ARGN}
        )
    if(CMUT__LANG__FUNCTION__DEBUG)
        set( MESSAGE "\n-- In function \"${__cmut__lang__function__function_name}\": arguments parsed :")
        foreach(v ${__cmut__lang__function__option_list})
            string( APPEND MESSAGE "\n--    ${v} = ${${__cmut__lang__function__arg_prefix}_${v}}")
        endforeach()
        foreach(v ${__cmut__lang__function__param_list})
            string( APPEND MESSAGE "\n--    ${v} = ${${__cmut__lang__function__arg_prefix}_${v}}")
        endforeach()
        foreach(v ${__cmut__lang__function__multi_param_list})
            string( APPEND MESSAGE "\n--    ${v} = ${${__cmut__lang__function__arg_prefix}_${v}}")
        endforeach()

        cmut__log__debug_if( cmut__lang__function__parse_arguments "${MESSAGE}" CMUT__LANG__FUNCTION__DEBUG)
    endif()

    foreach(param IN LISTS __cmut__lang__function__param_list)
        if(DEFINED __cmut__lang__function__param_default__${param})
            if(NOT DEFINED ${__cmut__lang__function__arg_prefix}_${param})
                set( ${__cmut__lang__function__arg_prefix}_${param} "${__cmut__lang__function__param_default__${param}}" )
                cmut__log__debug_if( cmut__lang__function__parse_arguments
                    "set ${param} to default value (${__cmut__lang__function__param_default__${param}})"
                    CMUT__LANG__FUNCTION__DEBUG)
            endif()
        endif()
    endforeach()

    foreach(param IN LISTS __cmut__lang__function__multi_param_list)
        if(DEFINED __cmut__lang__function__multi_param_default__${param})
            if(NOT DEFINED ${__cmut__lang__function__arg_prefix}_${param})
                set( ${__cmut__lang__function__arg_prefix}_${param} "${__cmut__lang__function__multi_param_default__${param}}" )
                cmut__log__debug_if( cmut__lang__function__parse_arguments
                    "set ${param} to default value (${__cmut__lang__function__multi_param_default__${param}})"
                    CMUT__LANG__FUNCTION__DEBUG)
            endif()
        endif()
    endforeach()


    if( ${__cmut__lang__function__exclusive_option_list} )
        foreach( name IN LISTS __cmut__lang__function__exclusive_option_list )
            foreach( option IN LISTS __cmut__lang__function__exclusive_option_list__${name} )
                if( DEFINED ARG_${option} )
                    if( NOT __cmut__lang__function__exclusive_option_defined__${name} )
                        set( __cmut__lang__function__exclusive_option_defined__${name} 1)
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
