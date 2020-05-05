

function(cmut__install__header_directories target)

    cmut__lang__function__init_param( cmut__install__header )
    cmut__lang__function__add_param( DESTINATION    DEFAULT ${CMAKE_INSTALL_INCLUDEDIR} )
    cmut__lang__function__add_param( COMPONENT      DEFAULT devel )
    cmut__lang__function__parse_arguments( ${ARGN} )


    set( header_scopes INTERFACE )
    
    get_target_property(target_type ${target} TYPE)    
    if ( NOT target_type STREQUAL INTERFACE_LIBRARY )
        list( APPEND header_scopes PUBLIC )
    endif()
    
    foreach( scope IN LISTS header_scopes )
        cmut__target__get_header_directories( header_directories ${target} ${scope})
        if( header_directories )
            install(
                DIRECTORY   "${header_directories}"
                DESTINATION "${ARG_DESTINATION}"
                COMPONENT   ${ARG_COMPONENT}
            )
        endif()
    endforeach()

endfunction()


