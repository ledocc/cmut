

function(cmut__config__add_dependencies project package)

    macro(set_if_define var)
        if(DEFINED ARG__${var})
            set(${project}_DEPENDENCIES_${package}_${var} ${ARG__${var}})
            cmut__utils__set_in_parent_scope(${project}_DEPENDENCIES_${package}_${var})
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
    cmut__utils__set_in_parent_scope(${project}_DEPENDENCIES)


    if(DEFINED ARG__REQUIRED)
        set(${project}_DEPENDENCIES_${package}_REQUIRED REQUIRED)
        cmut__utils__set_in_parent_scope(${project}_DEPENDENCIES_${package}_REQUIRED)
    endif()

    set_if_define(VERSION)
    set_if_define(FIND_PACKAGE_NAME)
    set_if_define(COMPONENTS)
    set_if_define(NAMES)


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

macro(__cmut__config__copy_dependencies_package__variable variable package project_source project_destination)

    if( DEFINED ${project_source}_DEPENDENCIES_${package}_${variable} )
        set( ${project_destination}_DEPENDENCIES_${package}_${variable} ${${project_source}_DEPENDENCIES_${package}_${variable}} )
    endif()

endmacro()

macro(__cmut__config__copy_dependencies_package__list list_name package project_source project_destination)

    if( DEFINED ${project_source}_DEPENDENCIES_${package}_${list_name} )
        list( APPEND ${project_destination}_DEPENDENCIES_${package}_${list_name} "${${project_source}_DEPENDENCIES_${package}_${list_name}}" )
        list( REMOVE_DUPLICATES ${project_destination}_DEPENDENCIES_${package}_${list_name} )
    endif()

endmacro()


# copy dependencies from project source to project destination
# usefull in a super project that collect its subproject dependencies
function(cmut__config__copy_dependencies project_source project_destination)

    __cmut__config__copy_dependencies_list( ${project_source} ${project_destination} )

    foreach(package IN LISTS ${project_source}_DEPENDENCIES)

        __cmut__config__copy_dependencies_package_version( ${package} ${project_source} ${project_destination} )
        __cmut__config__copy_dependencies_package__variable( REQUIRED ${package} ${project_source} ${project_destination} )
        __cmut__config__copy_dependencies_package__variable( FIND_PACKAGE_NAME ${package} ${project_source} ${project_destination} )
        __cmut__config__copy_dependencies_package__list( COMPONENTS ${package} ${project_source} ${project_destination} )
        __cmut__config__copy_dependencies_package__list( NAMES ${package} ${project_source} ${project_destination} )

    endforeach()

    cmut__config__set_dependencies_in_parent_scope( ${project_destination} )

endfunction()


macro(cmut__config__set_dependencies_in_parent_scope project )

    foreach(package IN LISTS ${project}_DEPENDENCIES)

        cmut__utils__set_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_VERSION )
        cmut__utils__set_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_REQUIRED )
        cmut__utils__set_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_FIND_PACKAGE_NAME )
        cmut__utils__set_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_COMPONENTS )
        cmut__utils__set_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_NAMES )

    endforeach()

    cmut__utils__set_in_parent_scope_if_defined( ${project}_DEPENDENCIES )

endmacro()



macro( __cmut__config__set_if_defined opt )

    if( DEFINED ${current_project}_DEPENDENCIES_${package}_${opt} )
        set( ${opt}_OPTION ${ARGN} ${${current_project}_DEPENDENCIES_${package}_${opt}} )
    else()
        set( ${opt}_OPTION )
    endif()
endmacro()

macro(cmut__config__find_dependencies project)

    set(current_project ${project})
    foreach(package IN LISTS ${project}_DEPENDENCIES)

        __cmut__config__set_if_defined( VERSION )
        __cmut__config__set_if_defined( REQUIRED )
        __cmut__config__set_if_defined( COMPONENTS COMPONENTS )
        __cmut__config__set_if_defined( NAMES      NAMES )

        if(DEFINED ${project}_DEPENDENCIES_${package}_FIND_PACKAGE_NAME)
            set(package ${${project}_DEPENDENCIES_${package}_FIND_PACKAGE_NAME})
        endif()

        message(STATUS "Looking for ${package}")

        find_package(${package}
            ${VERSION_OPTION}
            ${REQUIRED_OPTION}
            ${COMPONENTS_OPTION}
            ${NAMES_OPTION}
            )

    endforeach()

endmacro()
