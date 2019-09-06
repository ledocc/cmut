
function(cmut__target__get_property_prefix result target )

    get_target_property(target_type ${target} TYPE)
    if ( target_type STREQUAL INTERFACE_LIBRARY )
        cmut__lang__return_value( INTERFACE_ )
    endif()

endfunction()
