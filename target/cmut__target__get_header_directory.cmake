
function( cmut__target__get_private_header_directories result target )

    get_target_property( header_directories ${target} CMUT__TARGET__PRIVATE_HEADER_DIRECTORIES )
    cmut__lang__return( header_directories )

endfunction()

function( cmut__target__get_public_header_directories result target )

    get_target_property( header_directories ${target} CMUT__TARGET__PUBLIC_HEADER_DIRECTORIES )
    cmut__lang__return( header_directories )

endfunction()
