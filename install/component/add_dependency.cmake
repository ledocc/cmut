
function(cmut__install__component__add_dependencies component)

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

    if( TARGET install_${component} )
        cmut__install__component__add_dependencies__impl( install_${component} ${ARGN} )
    endif()

endfunction()


function(cmut__install__component__add_dependencies__impl target )

        add_dependencies( ${target} ${ARGN} )

endfunction()
