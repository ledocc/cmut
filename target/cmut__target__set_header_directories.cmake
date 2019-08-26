
function( cmut__target__set_public_header_directories target header_directories )

    set_target_properties( ${target}
        PROPERTIES
            CMUT__TARGET__PUBLIC_HEADER_DIRECTORIES "${header_directories}"
        )

endfunction()

function( cmut__target__set_private_header_directories target header_directories )

    set_target_properties( ${target}
        PROPERTIES
            CMUT__TARGET__PRIVATE_HEADER_DIRECTORIES "${header_directories}"
        )

endfunction()
