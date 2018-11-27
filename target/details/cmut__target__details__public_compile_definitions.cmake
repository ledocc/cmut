

function( cmut__target__details__public_compile_definitions target)

    set( scope PUBLIC )

    get_target_property(target_type ${target} TYPE)
    if( "${target_type}" STREQUAL "INTERFACE_LIBRARY")
        set( scope INTERFACE )
    endif()

    target_compile_definitions( ${target} ${scope} ${ARGN} )

endfunction()
