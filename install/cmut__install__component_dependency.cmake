



function(cmut__install__add_component_dependency component)

    if(ARGC LESS 2)
        return()
    endif()


    set_property(
        GLOBAL
        APPEND
        PROPERTY
            CMUT__INSTALL__${component}_COMPONENTS_DEPENDENCIES
        "${ARGN}"
    )

    if(TARGET install_${component})
        add_dependencies(install_${component} "${ARGN}")
    endif()

endfunction()


function(cmut__install__get_component_dependency component result)

    get_property(value
        GLOBAL
        PROPERTY
            CMUT__INSTALL__${component}_COMPONENTS_DEPENDENCIES
    )

    set(${result} ${value} PARENT_SCOPE)

endfunction()
