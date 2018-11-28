

function(cmut__config__add_dependencies project package)

    macro(export_to_parent_scope var)
        set(${var} ${${var}} PARENT_SCOPE)
    endmacro()


    cmake_parse_arguments(
        ARG_
        "REQUIRED"
        "VERSION"
        "COMPONENTS"
        ${ARGN}
        )

    list(APPEND ${project}_DEPENDENCIES ${package})
    export_to_parent_scope(${project}_DEPENDENCIES)


    if(DEFINED ARG__REQUIRED)
        set(${project}_DEPENDENCIES_${package}_REQUIRED REQUIRED)
        export_to_parent_scope(${project}_DEPENDENCIES_${package}_REQUIRED)
    endif()

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



macro(__cmut__config__copy_dependencies_list project_source project_destination)

    if( DEFINED ${project_source}_DEPENDENCIES )
        list( APPEND ${project_destination}_DEPENDENCIES "${${project_source}_DEPENDENCIES}" )
        list( REMOVE_DUPLICATES ${project_destination}_DEPENDENCIES )
    endif()

endmacro()

macro(__cmut__config__copy_dependencies_package_version package project_source project_destination)

    if( ( DEFINED ${project_source}_DEPENDENCIES_${package}_VERSION )
        AND
        ( ${project_source}_DEPENDENCIES_${package}_VERSION VERSION_GREATER ${project_destination}_DEPENDENCIES_${package}_VERSION ) )
        set( ${project_destination}_DEPENDENCIES_${package}_VERSION ${${project_source}_DEPENDENCIES_${package}_VERSION} )
    endif()

endmacro()

macro(__cmut__config__copy_dependencies_package_required package project_source project_destination)

    if( DEFINED ${project_source}_DEPENDENCIES_${package}_REQUIRED )
        set( ${project_destination}_DEPENDENCIES_${package}_REQUIRED ${${project_source}_DEPENDENCIES_${package}_REQUIRED} )
    endif()

endmacro()

macro(__cmut__config__copy_dependencies_package_component package project_source project_destination)

    if( DEFINED ${project_source}_DEPENDENCIES_${package}_COMPONENTS )
        list( APPEND ${project_destination}_DEPENDENCIES_${package}_COMPONENTS "${${project_source}_DEPENDENCIES_${package}_COMPONENTS}" )
        list( REMOVE_DUPLICATES ${project_destination}_DEPENDENCIES_${package}_COMPONENTS )
    endif()


endmacro()


# copy dependencies from project source to project destination
# usefull in a super project that collect its subproject dependencies
function(cmut__config__copy_dependencies project_source project_destination)

    __cmut__config__copy_dependencies_list( ${project_source} ${project_destination} )

    foreach(package IN LISTS ${project_source}_DEPENDENCIES)

        __cmut__config__copy_dependencies_package_version( ${package} ${project_source} ${project_destination} )
        __cmut__config__copy_dependencies_package_required( ${package} ${project_source} ${project_destination} )
        __cmut__config__copy_dependencies_package_component( ${package} ${project_source} ${project_destination} )

    endforeach()

    cmut__config__set_dependencies_in_parent_scope( ${project_destination} )

endfunction()


macro(cmut__config__set_dependencies_in_parent_scope project )

    foreach(package IN LISTS ${project}_DEPENDENCIES)

        cmut__utils__set_variable_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_VERSION )
        cmut__utils__set_variable_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_REQUIRED )
        cmut__utils__set_variable_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_COMPONENTS )

    endforeach()

    cmut__utils__set_variable_in_parent_scope_if_defined( ${project}_DEPENDENCIES )

endmacro()


macro(cmut__config__find_dependencies project)

    foreach(package IN LISTS ${project}_DEPENDENCIES)

        message(STATUS "Looking for ${package}")
        find_package(${package} ${${project}_DEPENDENCIES_${package}_VERSION} ${${project}_DEPENDENCIES_${package}_REQUIRED}
            COMPONENTS
            ${${project}_DEPENDENCIES_${package}_COMPONENTS}
            )

    endforeach()

endmacro()
