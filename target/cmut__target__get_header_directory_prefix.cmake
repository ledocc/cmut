
function( cmut__target__get_header_directory_prefix result target )

    get_target_property( header_directory_prefix ${target} CMUT__TARGET__HEADER_DIRECTORY_PREFIX )
    cmut__lang__return( header_directory_prefix )

endfunction()
