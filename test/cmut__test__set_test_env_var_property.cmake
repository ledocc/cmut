

function( cmut__test__append_env_var name env_var )

    get_test_property(${name} ENVIRONMENT test_env_var)
    list(APPEND test_env_var "${env_var}")
    set_tests_properties(${name} PROPERTIES ENVIRONMENT "${test_env_var}")

endfunction()

function( cmut__test__prepend_env_var name env_var )

    get_test_property(${name} ENVIRONMENT test_env_var)
    list(INSERT test_env_var 0 "${env_var}")
    set_tests_properties(${name} PROPERTIES ENVIRONMENT "${test_env_var}")

endfunction()









function(cmut__test__set_test_env_var_property env_var namespace)

    foreach(test IN LISTS ARGN)

        cmut__test__make_test_name(${namespace} ${test} name)

        set_tests_properties(${name} PROPERTIES ENVIRONMENT "${env_var}")

    endforeach()

endfunction()
