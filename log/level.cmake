include_guard(GLOBAL)


cmake_policy(PUSH)
cmake_policy(SET CMP0057 NEW)



set( CMUT__LOG__LEVEL__LIST fatal error warning info debug )
set( CMUT__LOG__LEVEL__DEFAULT info )

set( CMUT__LOG__LEVEL__fatal_STRING    "<fatal>  " )
set( CMUT__LOG__LEVEL__error_STRING    "<error>  " )
set( CMUT__LOG__LEVEL__warning_STRING  "<warn>   " )
set( CMUT__LOG__LEVEL__info_STRING     "<info>   " )
set( CMUT__LOG__LEVEL__debug_STRING    "<debug>  " )
set( CMUT__LOG__LEVEL__dev_STRING      "<dev>    " )

set( CMUT__LOG__LEVEL__fatal_MODE    FATAL_ERROR )
set( CMUT__LOG__LEVEL__error_MODE    SEND_ERROR )
set( CMUT__LOG__LEVEL__warning_MODE  WARNING )
set( CMUT__LOG__LEVEL__info_MODE     STATUS )
set( CMUT__LOG__LEVEL__debug_MODE    STATUS )
set( CMUT__LOG__LEVEL__dev_MODE      STATUS )

set( CMUT__LOG__LEVEL__fatal_COLOR ${CMUT__LOG__COLOR__Blink}${CMUT__LOG__COLOR__Red})
set( CMUT__LOG__LEVEL__fatal_message_color ${CMUT__LOG__COLOR__Red})
set( CMUT__LOG__LEVEL__error_COLOR ${CMUT__LOG__COLOR__Bold}${CMUT__LOG__COLOR__Red})
set( CMUT__LOG__LEVEL__error_message_color ${CMUT__LOG__COLOR__Red})
set( CMUT__LOG__LEVEL__warn_COLOR ${CMUT__LOG__COLOR__Red})
set( CMUT__LOG__LEVEL__warn_message_color ${CMUT__LOG__COLOR__Red})
set( CMUT__LOG__LEVEL__info_COLOR ${CMUT__LOG__COLOR__Green})
set( CMUT__LOG__LEVEL__info_MESSAGE_COLOR )
set( CMUT__LOG__LEVEL__debug_COLOR ${CMUT__LOG__COLOR__Blue})
set( CMUT__LOG__LEVEL__debug_MESSAGE_COLOR )


function( cmut__log__level__init )

    set(index 0)
    foreach( level IN LISTS CMUT__LOG__LEVEL__LIST )
        set( CMUT__LOG__LEVEL__${level}_VALUE ${index} PARENT_SCOPE )
        math( EXPR index "${index}+1" )
    endforeach()

    if( NOT DEFINED CMUT__LOG__LEVEL )
        if( DEFINED ENV{CMUT__LOG__LEVEL} )
            set( CMUT__LOG__LEVEL $ENV{CMUT__LOG__LEVEL} PARENT_SCOPE )
        else()
            set( CMUT__LOG__LEVEL ${CMUT__LOG__LEVEL__DEFAULT} PARENT_SCOPE )
        endif()
    endif()

endfunction()


function( cmut__log__level__on_change )

    if ( NOT CMUT__LOG__LEVEL IN_LIST CMUT__LOG__LEVEL__LIST )
        message( WARNING "[cmut][log] : Invalid log level : \"${CMUT__LOG__LEVEL}\". "
                         "Valid level are ${CMUT__LOG__LEVEL__LIST}. "
                         "CMUT__LOG__LEVEL reset to \"${CMUT__LOG__LEVEL__DEFAULT}\"." )
        set( CMUT__LOG__LEVEL ${CMUT__LOG__LEVEL__DEFAULT} PARENT_SCOPE )
        return()
    endif()

    macro( set_is_enable level )
        string( TOUPPER ${level} levelUpper )
        if( CMUT__LOG__LEVEL__${CMUT__LOG__LEVEL}_VALUE GREATER_EQUAL CMUT__LOG__LEVEL__${level}_VALUE)
            set(CMUT__LOG__IS_${levelUpper}_ENABLE 1 PARENT_SCOPE)
        else()
            set(CMUT__LOG__IS_${levelUpper}_ENABLE 0 PARENT_SCOPE)
        endif()
    endmacro()

    foreach(level IN LISTS CMUT__LOG__LEVEL__LIST)
        set_is_enable( ${level} )
    endforeach()

endfunction()


cmut__log__level__init()
#message(STATUS "[cmut][log] : CMUT__LOG__LEVEL = ${CMUT__LOG__LEVEL}.")
cmut__log__level__on_change()
variable_watch(CMUT__LOG__LEVEL cmut__log__level__on_change)

cmake_policy(POP)
