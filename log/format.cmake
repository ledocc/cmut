include_guard(GLOBAL)

include("${CMAKE_CURRENT_LIST_DIR}/color.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/level.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../lang/return.cmake")



function( cmut__log__format__function_name_to_scope_name result function_name )

    string( REGEX REPLACE "__" "][" scope_name ${function_name} )
    set( scope_name "[${scope_name}]" )
    cmut__lang__return( scope_name )

endfunction()

set( CMUT__LOG__FORMAT__CMUT_COLOR "${CMUT__LOG__COLOR__Bold}${CMUT__LOG__COLOR__Blue}")


function( cmut__log__format level message )

    string( TIMESTAMP timestamp )

    set( formated_message
"\
${CMUT__LOG__FORMAT__CMUT_COLOR}[cmut]${CMUT__LOG__COLOR__Reset} [${timestamp}] \
${CMUT__LOG__LEVEL__${level}_COLOR}${CMUT__LOG__LEVEL__${level}_STRING}${CMUT__LOG__COLOR__Reset} : \
${CMUT__LOG__LEVEL__${level}_MESSAGE_COLOR}${message}${CMUT__LOG__COLOR__Reset}"
)

    message( ${CMUT__LOG__LEVEL__${level}_MODE} "${formated_message}" )

endfunction()
