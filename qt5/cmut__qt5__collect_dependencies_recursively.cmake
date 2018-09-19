
function(cmut__qt5__collect_dependencies_recursively result target)

    cmut__utils__collect_dependencies_recursively(dependencies ${target})

    set(qt_dependencies)
    foreach(dependency IN LISTS dependencies)
        if( dependency MATCHES "Qt5::(.*)" )
            list( APPEND qt_dependencies ${CMAKE_MATCH_1} )
        endif()
    endforeach()

    set( ${result} ${dependencies} )

 endfunction()
