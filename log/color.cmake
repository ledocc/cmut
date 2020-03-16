include_guard(GLOBAL)

include("${CMAKE_CURRENT_LIST_DIR}/../lang/return.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../utils/tput.cmake")



function(cmut__log__get_num_available_colors result default )

    cmut__utils__tput( num_available_colors 1 colors )
    cmut__lang__return( num_available_colors )

endfunction()


if(DEFINED ENV{CMUT__LOG__NO_COLOR} )
    set( CMUT__LOG__ENV_NO_COLOR 0 )
endif()

option( CMUT__LOG__COLOR "use color in cmut log." ON )
message(DEBUG "CMUT__LOG__COLOR = ${CMUT__LOG__COLOR}")
message(DEBUG "CMUT__LOG__ENV_NO_COLOR  = ${CMUT__LOG__ENV_NO_COLOR}")



if( CMUT__LOG__COLOR AND NOT CMUT__LOG__ENV_NO_COLOR )

    if( "$ENV{SESSIONNAME}" STREQUAL "Console" )
        message( STATUS "use windows CMD color" )
        set( CMUT__LOG__COLOR__Bold          [1m )
        set( CMUT__LOG__COLOR__Reset         [0m )
        set( CMUT__LOG__COLOR__Standout      [0m )
        set( CMUT__LOG__COLOR__ExitStandout  )
        set( CMUT__LOG__COLOR__Underline     [4m )
        set( CMUT__LOG__COLOR__ExitUnderline [24m )
        set( CMUT__LOG__COLOR__Blink         )
        set( CMUT__LOG__COLOR__Black         [30m )
        set( CMUT__LOG__COLOR__Red           [31m )
        set( CMUT__LOG__COLOR__Green         [32m )
        set( CMUT__LOG__COLOR__Yellow        [33m )
        set( CMUT__LOG__COLOR__Blue          [34m )
        set( CMUT__LOG__COLOR__Magenta       [35m )
        set( CMUT__LOG__COLOR__Cyan          [36m )
        set( CMUT__LOG__COLOR__White         [37m )

    else()

        cmut__utils__tput( num_available_colors 1 colors )
        message(STATUS "num_available_colors = ${num_available_colors}")

        if( num_available_colors GREATER_EQUAL 8 )
            message(STATUS pass)

            cmut__utils__tput( CMUT__LOG__COLOR__Bold          "" bold )
            cmut__utils__tput( CMUT__LOG__COLOR__Reset         "" sgr0 )
            cmut__utils__tput( CMUT__LOG__COLOR__Standout      "" smso )
            cmut__utils__tput( CMUT__LOG__COLOR__ExitStandout  "" rmso )
            cmut__utils__tput( CMUT__LOG__COLOR__Underline     "" smul )
            cmut__utils__tput( CMUT__LOG__COLOR__ExitUnderline "" rmul )
            cmut__utils__tput( CMUT__LOG__COLOR__Blink         "" blink )
            cmut__utils__tput( CMUT__LOG__COLOR__Black         "" setaf 0 )
            cmut__utils__tput( CMUT__LOG__COLOR__Red           "" setaf 1 )
            cmut__utils__tput( CMUT__LOG__COLOR__Green         "" setaf 2 )
            cmut__utils__tput( CMUT__LOG__COLOR__Yellow        "" setaf 3 )
            cmut__utils__tput( CMUT__LOG__COLOR__Blue          "" setaf 4 )
            cmut__utils__tput( CMUT__LOG__COLOR__Magenta       "" setaf 5 )
            cmut__utils__tput( CMUT__LOG__COLOR__Cyan          "" setaf 6 )
            cmut__utils__tput( CMUT__LOG__COLOR__White         "" setaf 7 )

        endif()
    endif()
endif()

