
function(cmut__test__set_test_env_var_property env_var namespace)

    foreach(test IN LISTS ARGN)

        cmut__test__make_test_name(${namespace} ${test} name)

        set_tests_properties(${name} PROPERTIES ENVIRONMENT "${env_var}")

    endforeach()

endfunction()
