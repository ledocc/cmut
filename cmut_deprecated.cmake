include("${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__header_guard.cmake")
cmut__utils__define_header_guard()

include("${CMAKE_CURRENT_LIST_DIR}/cmut_message.cmake")

function(cmut_deprecated_message what replacement)
    if( "$ENV{CMUT__DISABLE_DEPRECATED_WARNING}" STREQUAL "" )

        set( msg "cmut ${what} is deprecated" )
        if(replacement)
            string( APPEND msg ", prefer ${replacement} instead" )
        endif()
        string( APPEND msg "." )

        cmut_warn( "${msg}" )

    endif()
endfunction()

########################################################################################################################
########################################################################################################################
########################################################################################################################

function(cmut_deprecated_message__private type old new)
    cmut_deprecated_message("${type} \"${old}\"" "\"${new}\"")
endfunction()

########################################################################################################################

function( cmut_deprecated old )
    cmut_deprecated_message__private( "file" "${old}" ${ARGN} )
endfunction()

function( cmut_deprecated_function old )
    cmut_deprecated_message__private( "function" "${old}" ${ARGN} )
endfunction()

function( cmut_deprecated_variable old )
    cmut_deprecated_message__private( "variable" "${old}" "${ARGN}" )
endfunction()

function( cmut_deprecated_env_variable old )
    cmut_deprecated_message__private( "environment variable" "${old}" "${ARGN}" )
endfunction()

function( cmut_deprecated_parameter old )
    cmut_deprecated_message__private( "parameter" "${old}" ${ARGN} )
endfunction()

function( cmut_deprecated_include old )
    cmut_deprecated_message__private( "include" "${old}" ${ARGN} )
endfunction()
