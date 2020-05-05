



function(cmut__install__headers)

    cmut__lang__function__init_param( cmut__install__header )
    cmut__lang__function__add_param( DESTINATION    DEFAULT ${CMAKE_INSTALL_INCLUDEDIR} )
    cmut__lang__function__add_param( COMPONENT      DEFAULT devel )
    cmut__lang__function__add_param( DIRECTORY_BASE )
    cmut__lang__function__add_multi_param( HEADERS )
    cmut__lang__function__parse_arguments( ${ARGN} )
    
    foreach( filepath ${ARG_HEADERS} )

        if( NOT EXISTS ${filepath} )
            continue()
        endif()

        get_filename_component( directory "${filepath}" DIRECTORY )
        if( DEFINED ARG_DIRECTORY_BASE )
            file( RELATIVE_PATH directory ${ARG_DIRECTORY_BASE} ${directory} )
        endif()

        install(
            FILES       "${filepath}"
            DESTINATION "${ARG_DESTINATION}/${directory}"
            COMPONENT   ${ARG_COMPONENT}
            )

    endforeach()

endfunction()
