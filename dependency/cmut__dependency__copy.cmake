
macro(__cmut__dependency__copy_list project_source project_destination)

    if( DEFINED ${project_source}_DEPENDENCIES )
        list( APPEND ${project_destination}_DEPENDENCIES "${${project_source}_DEPENDENCIES}" )
        list( REMOVE_DUPLICATES ${project_destination}_DEPENDENCIES )
    endif()

endmacro()

macro(__cmut__dependency__copy__package_version package project_source project_destination)

    if( ( DEFINED ${project_source}_DEPENDENCIES_${package}_VERSION )
        AND
        ( ${project_source}_DEPENDENCIES_${package}_VERSION VERSION_GREATER ${project_destination}_DEPENDENCIES_${package}_VERSION ) )
        set( ${project_destination}_DEPENDENCIES_${package}_VERSION ${${project_source}_DEPENDENCIES_${package}_VERSION} )
    endif()

endmacro()

macro(__cmut__dependency__copy__package__variable variable package project_source project_destination)

    if( DEFINED ${project_source}_DEPENDENCIES_${package}_${variable} )
        set( ${project_destination}_DEPENDENCIES_${package}_${variable} ${${project_source}_DEPENDENCIES_${package}_${variable}} )
    endif()

endmacro()

macro(__cmut__dependency__copy__package__list list_name package project_source project_destination)

    if( DEFINED ${project_source}_DEPENDENCIES_${package}_${list_name} )
        list( APPEND ${project_destination}_DEPENDENCIES_${package}_${list_name} "${${project_source}_DEPENDENCIES_${package}_${list_name}}" )
        list( REMOVE_DUPLICATES ${project_destination}_DEPENDENCIES_${package}_${list_name} )
    endif()

endmacro()


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

# copy dependencies from project source to project destination
# usefull in a super project that collect its subproject dependencies
function(cmut__dependency__copy project_source project_destination)

    __cmut__dependency__copy_list( ${project_source} ${project_destination} )

    foreach(package IN LISTS ${project_source}_DEPENDENCIES)

        __cmut__dependency__copy__package_version( ${package} ${project_source} ${project_destination} )
        __cmut__dependency__copy__package__variable( REQUIRED ${package} ${project_source} ${project_destination} )
        __cmut__dependency__copy__package__variable( FIND_PACKAGE_NAME ${package} ${project_source} ${project_destination} )
        __cmut__dependency__copy__package__list( COMPONENTS ${package} ${project_source} ${project_destination} )
        __cmut__dependency__copy__package__list( NAMES ${package} ${project_source} ${project_destination} )

    endforeach()

    cmut__dependency__set_in_parent_scope( ${project_destination} )

endfunction()
