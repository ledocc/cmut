

function( cmut__target__get_internal_dependencies result target )

    get_target_property(dependencies ${target} INTERFACE_LINK_LIBRARIES)
    foreach(dependency IN LISTS dependencies)

        if(NOT TARGET ${dependency})
            continue()
        endif()

        get_target_property(is_imported ${dependency} IMPORTED)
        if( is_imported )
            continue()
        endif()

        list( APPEND internal_dependencies ${dependency})

    endforeach()


    cmut__lang__return( internal_dependencies )

endfunction()
