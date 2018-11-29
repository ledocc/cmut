

## cmut__dependency__find( project )
## brief: call cmake's "find_package" function with data regidtered by "cmut__dependency__add" for the project "project"
##
## cmut__dependency__find have to be a macro to allow <packageName>Config.cmake script to define variable in global scope
macro( cmut__dependency__find project )

    macro( __cmut__dependency__set_if_defined opt )
        if( DEFINED ${project}_DEPENDENCIES_${package}_${opt} )
            set( ${opt}_OPTION ${ARGN} ${${project}_DEPENDENCIES_${package}_${opt}} )
        else()
            set( ${opt}_OPTION )
        endif()
    endmacro()


    foreach(package IN LISTS ${project}_DEPENDENCIES)

        __cmut__dependency__set_if_defined( VERSION )
        __cmut__dependency__set_if_defined( REQUIRED )
        __cmut__dependency__set_if_defined( COMPONENTS COMPONENTS )
        __cmut__dependency__set_if_defined( NAMES      NAMES )

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
