function(cmut__target__get_property_prefix result target)

    set(property_prefix)
    get_target_property(target_type ${target} TYPE)
    if (target_type STREQUAL INTERFACE_LIBRARY)
        set(property_prefix INTERFACE_)
    endif()

    cmut__lang__return(property_prefix)

endfunction()
