
cmake_policy(PUSH)
cmake_policy(SET CMP0057 NEW)

set(CMUT__LOG__LEVEL_LIST fatal error warning info debug)
set(CMUT__LOG__DEFAULT_LEVEL info)

function(cmut__log__init)
    set(index 0)
    foreach(level IN LISTS CMUT__LOG__LEVEL_LIST)
        set(CMUT__LOG__LEVEL_${level}__VALUE ${index} PARENT_SCOPE)
        math(EXPR index "${index}+1")
    endforeach()

    if(NOT DEFINED CMUT__LOG__LEVEL)
        if(DEFINED ENV{CMUT__LOG__LEVEL})
            set(CMUT__LOG__LEVEL $ENV{CMUT__LOG__LEVEL} PARENT_SCOPE)
        else()
            set(CMUT__LOG__LEVEL ${CMUT__LOG__DEFAULT_LEVEL} PARENT_SCOPE)
        endif()
    endif()
endfunction()


function( cmut__log__on_level_change )

    if (NOT CMUT__LOG__LEVEL IN_LIST CMUT__LOG__LEVEL_LIST)
        message( WARNING "[cmut][log] : Invalid log level : \"${CMUT__LOG__LEVEL}\". "
                         "Valid level are ${CMUT__LOG__LEVEL_LIST}. "
                         "CMUT__LOG__LEVEL reset to \"${CMUT__LOG__DEFAULT_LEVEL}\"." )
        set( CMUT__LOG__LEVEL ${CMUT__LOG__DEFAULT_LEVEL} PARENT_SCOPE )
        return()
    endif()

    macro(set_is_enable level)
        string(TOUPPER ${level} levelUpper)
        if(CMUT__LOG__LEVEL_${CMUT__LOG__LEVEL}__VALUE GREATER_EQUAL CMUT__LOG__LEVEL_${level}__VALUE)
            set(CMUT__LOG__IS_${levelUpper}_ENABLE 1)
        else()
            set(CMUT__LOG__IS_${levelUpper}_ENABLE 0)
        endif()
    endmacro()

    foreach(level IN LISTS CMUT__LOG__LEVEL_LIST)
        set_is_enable( ${level} )
    endforeach()

endfunction()


cmut__log__init()
cmut__log__on_level_change()
variable_watch(CMUT__LOG__LEVEL cmut__log__on_level_change)

cmake_policy(POP)
