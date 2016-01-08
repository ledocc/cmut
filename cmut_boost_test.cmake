# from Eric Scott Barr
# http://ericscottbarr.com/blog/2015/06/driving-boost-dot-test-with-cmake/

# conveniant function to add boost test

include(CMakePrintHelpers)
function(cmut_add_boost_test test_src_file dependency_lib_list)

    get_filename_component(_test_exec_name ${test_src_file} NAME_WE)

    add_executable(${_test_exec_name} ${test_src_file})

    target_include_directories(
        ${_test_exec_name} SYSTEM
        PUBLIC ${BOOST_INCLUDE_DIR}
    )

    target_link_libraries(
        ${_test_exec_name}
        ${${dependency_lib_list}}
        ${Boost_CHRONO_LIBRARIES}
        ${Boost_TIMER_LIBRARIES}
        ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}
    )

    file(READ "${test_src_file}" _contents)
    string(REGEX MATCHALL "BOOST_[A-Z]+_TEST_CASE\\([*, A-Za-z_0-9]+\\)"
        _test_instances ${_contents})

    foreach(_test ${_test_instances})

        string(REGEX REPLACE ".*\\( *([A-Za-z_0-9]+).*\\).*" "\\1" test_name ${_test})

        add_test(NAME "${_test_exec_name}.${test_name}"
            COMMAND ${_test_exec_name}
            --run_test=${test_name} --catch_system_error=yes)
    endforeach()

endfunction()

function(cmut_add_boost_tests test_src_files dependency_libs)

    foreach(file ${{test_src_files}})
        cmut_add_boost_test(${file} dependency_libs)
    endforeach()

endfunction()
