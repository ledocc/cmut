
function(cmut__project__get_build_time result)

    cmut__lang__arg__set_params( PARAM "NO_CACHE" "" "" )
    cmut__lang__arg__parse_defined_options( cmut__project__get_build_time ARG PARAM ${ARGN} )

    if( ( DEFINED ${result} ) AND ( NOT ARG_NO_CACHE ) )
        return()
    endif()

    string( TIMESTAMP time "%Y-%m-%d %H:%M:%S UTC" UTC )
    set( ${result} ${time} CACHE INTERNAL "" FORCE )
    cmut_info( "[cmut][project][get_build_time] : set time \"${time}\" in \"${result}\"" )

endfunction()
