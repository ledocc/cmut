
function( cmut__target__get_header_directories result target scope )

    cmut__target__get_property_prefix(prefix ${target})
    get_target_property( header_directories ${target} ${prefix}CMUT__TARGET__${scope}__HEADER_DIRECTORIES )

    cmut__lang__return( header_directories )

endfunction()
