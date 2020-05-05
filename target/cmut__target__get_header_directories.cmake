
function( cmut__target__get_header_directories result target scope )

    get_target_property( header_directories ${target} CMUT__TARGET__${scope}__HEADER_DIRECTORIES )
    cmut__lang__return( header_directories )

endfunction()
