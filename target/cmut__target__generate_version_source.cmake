
function(cmut__target__generate_version_source__collect_variable_to_forward result version_cpp_in)
    file( READ "${version_cpp_in}" lines )
    string( REGEX MATCHALL "@[A-Za-z0-9_]+@" matchs ${lines} )
    list( REMOVE_DUPLICATES matchs )

    foreach(element IN LISTS matchs)
        string( REGEX MATCH "[A-Za-z0-9_]+" variable ${element} )
        list(APPEND variables ${variable})
    endforeach()

    cmut__lang__return( variables )
endfunction()

function(cmut__target__generate_version_source__warning_if_variable_is_not_defined variablesToTest)
    foreach( variable IN LISTS ${variablesToTest} )
        if(NOT DEFINED ${variable} )
            cmut_warn( "[cmut][target][generate_version_source]: variable \"${variable}\" is required, but not defined." )
        endif()
    endforeach()
endfunction()





function(cmut__target__generate_version_source target version_cpp_in)

    set(version_cpp_out "version.cpp")

    cmut__target__generate_version_source__collect_variable_to_forward( variables "${version_cpp_in}")
    cmut__target__generate_version_source__warning_if_variable_is_not_defined( variables )

    configure_file(
        "${version_cpp_in}"
        "${version_cpp_out}"
        @ONLY
    )

    target_sources( ${target} PRIVATE
        "${CMAKE_CURRENT_BINARY_DIR}/${version_cpp_out}"
        )

    set_source_files_properties( ${version_cpp_out} PROPERTIES SKIP_AUTOMOC ON )

endfunction()
