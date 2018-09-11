

function(cmut__utils__collect_dependencies_recursively result target)

    set( dependenciesDone__ )
    cmut__utils__collect_dependencies_recursively__private( result__ ${target} dependenciesDone__ )

    list( REMOVE_DUPLICATES result__ )
    set( ${result} "${result__}" PARENT_SCOPE )

endfunction()

#######################################################################################################################

function(cmut__utils__collect_dependencies_recursively__private result target dependenciesDone)

    if( NOT TARGET "${target}" )
        return()
    endif()

    set( result_${target} )
    get_target_property(dependencies ${target} INTERFACE_LINK_LIBRARIES)
    if(NOT dependencies)
        return()
    else()
        list( APPEND result_${target} ${dependencies} )
    endif()

    set( dependenciesDone_${target} ${${dependenciesDone}} )
    foreach(dependency IN LISTS dependencies)

        if( NOT dependency IN_LIST dependenciesDone_${target} )

            set( result_${target}_${dependency} )
            cmut__utils__collect_dependencies_recursively__private( result_${target}_${dependency}  ${dependency} dependenciesDone_${target} )

            list( APPEND dependenciesDone_${target} ${dependency} )
            list( APPEND result_${target} ${result_${target}_${dependency}} )

        endif()

    endforeach()

    set( ${dependenciesDone} ${dependenciesDone_${target}} PARENT_SCOPE )
    set( ${result} ${result_${target}} PARENT_SCOPE )

endfunction()
