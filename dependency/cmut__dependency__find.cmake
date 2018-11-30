

## cmut__dependency__find( project_in )
## brief: call cmake's "find_package" function with data regidtered by "cmut__dependency__add" for the project "project_in"
##
## cmut__dependency__find have to be a macro to allow <packageName>Config.cmake script to define variable in global scope
## This is a big trouble when script find by find_package (Find<packageName>.cmake or <packageName>Config.cmake) use this same macro.
## This start a recursive call of cmut__dependency__find, and project variable of outer call is replaced by the one in inner call, and so one.
## When the inner call return, project variable still have the value of inner call, and all go bad.
## To fix this, when create a stack that save the current project varible before call find_package, and pop it after call of find_variable.
macro( cmut__dependency__find project_in )


    set(project ${project_in})



    macro( stack__push value )
        list( APPEND __CMUT__DEPENDENCY__FIND__STACK ${value} )
    endmacro()

    macro( stack__pop variable )
        list( LENGTH    __CMUT__DEPENDENCY__FIND__STACK length )
        math( EXPR index "${length} - 1")
        list( GET       __CMUT__DEPENDENCY__FIND__STACK ${index} ${variable} )
        list( REMOVE_AT __CMUT__DEPENDENCY__FIND__STACK ${index} )
    endmacro()


    macro( set_if_defined opt )
        if( DEFINED ${project}_DEPENDENCIES_${package}_${opt} )
            set( ${opt}_OPTION ${ARGN} ${${project}_DEPENDENCIES_${package}_${opt}} )
        else()
            set( ${opt}_OPTION )
        endif()
    endmacro()


    foreach(package IN LISTS ${project}_DEPENDENCIES)

        set_if_defined( VERSION )
        set_if_defined( REQUIRED )
        set_if_defined( COMPONENTS COMPONENTS )
        set_if_defined( NAMES      NAMES )

        if(DEFINED ${project}_DEPENDENCIES_${package}_FIND_PACKAGE_NAME)
            set(package ${${project}_DEPENDENCIES_${package}_FIND_PACKAGE_NAME})
        endif()


        message(STATUS "Looking for ${package}")

        stack__push( ${project} )
        find_package(${package}
            ${VERSION_OPTION}
            ${REQUIRED_OPTION}
            ${COMPONENTS_OPTION}
            ${NAMES_OPTION}
            )
        stack__pop( project )


    endforeach()

endmacro()
