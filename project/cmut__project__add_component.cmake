

function( cmut__project__add_components component )

    set_property(
        GLOBAL
        APPEND
        PROPERTY
            CMUT__PROJECT__COMPONENTS__${PROJECT_NAME}
        "${component}"
    )

endfunction()

function( cmut__project__get_components result )

    get_property( components GLOBAL PROPERTY CMUT__PROJECT__COMPONENTS__${PROJECT_NAME} )
    cmut__lang__return( components )

endfunction()
