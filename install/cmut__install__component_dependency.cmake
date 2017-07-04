



function(cmut__install__add_component_dependency component)

    set_property(
        GLOBAL
        APPEND
        PROPERTY
            CMUT__INSTALL__${component}_COMPONENTS_DEPENDENCIES
        "${ARGN}"
    )

endfunction()


function(cmut__install__get_component_dependency component result)

    get_property(value
        GLOBAL
        PROPERTY
            CMUT__INSTALL__${component}_COMPONENTS_DEPENDENCIES
    )

    set(${result} ${value} PARENT_SCOPE)

endfunction()
