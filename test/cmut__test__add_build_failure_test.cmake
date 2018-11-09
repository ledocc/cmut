


function( cmut__test__add_build_failure_test )

    cmut__utils__parse_arguments(
        cmut__test__add_build_failure_test
        ARG
        ""
        "NAME;TEST_FRAMEWORK"
        "NAMESPACE;FILES;LIBRARIES"
        ${ARGN}
    )

    cmut__utils__test_required_argument( ARG_NAME "[cmut][test][add_build_failure_test] : NAME not defined." )
    if( NOT DEFINED ARG_FILES)
        set(ARG_FILES ${ARG_NAME}.test.cpp)
    endif()



    cmut__test__make_test_name( ${ARG_NAMESPACE} ${ARG_NAME} name )

    add_executable( ${name} ${ARG_FILES} )
    set_target_properties( ${name} PROPERTIES
        EXCLUDE_FROM_ALL TRUE
        EXCLUDE_FROM_DEFAULT_BUILD TRUE
    )


    add_test(
        NAME ${name}
        COMMAND ${CMAKE_COMMAND} --build . --target ${name} --config $<CONFIGURATION>
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )

    set_tests_properties(${name} PROPERTIES WILL_FAIL TRUE)


endfunction()
