
function(cmut__config__add_dependencies project package)

    macro(export_to_parent_scope var)
        set(${var} ${${var}} PARENT_SCOPE)
    endmacro()


    cmake_parse_arguments(
        ARG_
        ""
        "VERSION"
        "COMPONENTS"
        ${ARGN}
        )

    list(APPEND ${project}_DEPENDENCIES ${package})
    export_to_parent_scope(${project}_DEPENDENCIES)


    if(DEFINED ARG__VERSION)
        set(${project}_DEPENDENCIES_${package}_VERSION ${ARG__VERSION})
        export_to_parent_scope(${project}_DEPENDENCIES_${package}_VERSION)
    endif()

    if(DEFINED ARG__COMPONENTS)
        list(APPEND ${project}_DEPENDENCIES_${package}_COMPONENTS ${ARG__COMPONENTS})
        export_to_parent_scope(${project}_DEPENDENCIES_${package}_COMPONENTS)
    endif()


    string(REPLACE ";" " " args "${ARGN}")
    cmut_debug("[cmut][config] - add dependencies : ${package} ${args}")


endfunction()
