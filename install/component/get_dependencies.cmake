
function( cmut__install__component__get_dependencies result component )

    get_property(value
        GLOBAL
        PROPERTY
            CMUT__INSTALL__COMPONENTS__DEPENDENCIES__${component}
    )

    cmut__lang__return( value )

endfunction()
