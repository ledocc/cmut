# from Eric Scott Barr
# http://ericscottbarr.com/blog/2015/06/driving-boost-dot-test-with-cmake/

# conveniant function to add boost test

include(CMakePrintHelpers)

set(CMUT_TEST__HUNTER_BOOST_TEST_COMPONENTS
    chrono
    timer
    test
    )

set(CMUT_TEST__BOOST_TEST_COMPONENTS
    chrono
    timer
    unit_test_framework
    )

if(HUNTER_ENABLED)
    set(__cmut_test__boost_search_mode CONFIG)
endif()

macro(cmut_test__find_boost_test version)

    find_package(
        Boost ${version}
        REQUIRED COMPONENTS
            ${CMUT_TEST__BOOST_TEST_COMPONENTS}
        ${__cmut_test__boost_search_mode}
        )

    foreach(component ${CMUT_TEST__BOOST_TEST_COMPONENTS})
        link_libraries(
            Boost::${component}
            )
    endforeach()

    get_target_property(BUILD_TYPE Boost::unit_test_framework TYPE)
    if(NOT ${BUILD_TYPE} STREQUAL STATIC_LIBRARY)
        add_definitions(-DBOOST_TEST_DYN_LINK)
    endif()

endmacro()


function(cmut_add_boost_test namespace test_src_file)

    get_filename_component(_test_exec_name ${test_src_file} NAME_WE)

    get_filename_component(_path ${test_src_file} DIRECTORY)
    while(_path)


        get_filename_component(_dirname ${_path} NAME_WE)
        set(_test_exec_name "${_dirname}_${_test_exec_name}")
        get_filename_component(_path ${_path} DIRECTORY)

    endwhile()

    set(name ${namespace}_${_test_exec_name})

    add_executable(${name} ${test_src_file})

    add_test(NAME "${name}" COMMAND ${name})


#    file(READ "${test_src_file}" _contents)
#    string(REGEX MATCHALL "BOOST_[A-Z]+_TEST_CASE\\([:*, A-Za-z_0-9]+\\)"
#        _test_instances ${_contents})

#    foreach(_test ${_test_instances})

#        string(REGEX REPLACE ".*\\( *([A-Za-z_0-9]+).*\\).*" "\\1" test_name ${_test})

#        add_test(NAME "${_test_exec_name}.${test_name}"
#            COMMAND ${_test_exec_name}
#            --run_test=${test_name} --catch_system_error=yes)
#    endforeach()

endfunction()

function(cmut_add_boost_tests namespace)

    foreach(file ${ARGN})
        #message("add test ${file}")
        cmut_add_boost_test(${namespace} ${file})
    endforeach()

endfunction()
