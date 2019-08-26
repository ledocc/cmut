
function( cmut__target__set_header_directory_prefix target header_directory_prefix )

    set_target_property( ${target}
        PROPERTIES
            CMUT__TARGET__HEADER_DIRECTORY_PREFIX "${header_directory_prefix}"
        )

endfunction()
