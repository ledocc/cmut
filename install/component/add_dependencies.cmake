
function( cmut__install__component__add_dependencies component )

    if( ARGC LESS 2 )
        return()
    endif()

    set_property(
        GLOBAL
        APPEND
        PROPERTY
            CMUT__INSTALL__COMPONENTS__DEPENDENCIES__${component}
        "${ARGN}"
    )

    if( NOT TARGET install_${component} )
        cmut__install__component__make_target__impl( ${component} )
    endif()

    cmut__install__component__add_dependencies__impl( ${component} ${ARGN} )

endfunction()


function( cmut__install__component__add_dependencies__impl component )

        add_dependencies( install_${component} ${ARGN} )

endfunction()
