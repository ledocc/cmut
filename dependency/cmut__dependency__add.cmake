


function(cmut__dependency__add project package)

    macro(set_in_parent_scope variable)
        set( ${variable} "${${variable}}" PARENT_SCOPE )
    endmacro()

    macro(set_if_define var)
        if(DEFINED ARG__${var})
            set(${project}_DEPENDENCIES_${package}_${var} ${ARG__${var}})
            set_in_parent_scope(${project}_DEPENDENCIES_${package}_${var})
        endif()
    endmacro()


    cmake_parse_arguments(
        ARG_
        "REQUIRED"
        "VERSION;FIND_PACKAGE_NAME"
        "COMPONENTS;NAMES"
        ${ARGN}
        )

    list(APPEND ${project}_DEPENDENCIES ${package})
    list(REMOVE_DUPLICATES ${project}_DEPENDENCIES)
    set_in_parent_scope(${project}_DEPENDENCIES)


    if(DEFINED ARG__REQUIRED)
        set(${project}_DEPENDENCIES_${package}_REQUIRED REQUIRED)
        set_in_parent_scope(${project}_DEPENDENCIES_${package}_REQUIRED)
    endif()

    set_if_define(VERSION)
    set_if_define(FIND_PACKAGE_NAME)
    set_if_define(COMPONENTS)
    set_if_define(NAMES)

endfunction()
