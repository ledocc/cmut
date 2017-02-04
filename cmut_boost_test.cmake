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



function(cmut_test__find_boost_test version)

    if(HUNTER_ENABLED)
        hunter_add_package(
            Boost
            COMPONENTS
                ${CMUT_TEST__HUNTER_BOOST_TEST_COMPONENTS}
            )
    endif()


    find_package(
        Boost ${version}
        REQUIRED COMPONENTS
            ${CMUT_TEST__BOOST_TEST_COMPONENTS}
        ${__cmut_test__boost_search_mode}
        )

    if(NOT Boost_UNIT_TEST_FRAMEWORK_FOUND)
        cmut_warn("Can't found boost::unit_test_framework. Tests skipped.")
        return()
    endif()
    set(Boost_UNIT_TEST_FRAMEWORK_FOUND ${Boost_UNIT_TEST_FRAMEWORK_FOUND} PARENT_SCOPE)

    foreach(component ${CMUT_TEST__BOOST_TEST_COMPONENTS})
        link_libraries(
            Boost::${component}
            )
    endforeach()


    get_target_property(BUILD_TYPE Boost::unit_test_framework TYPE)
    if(NOT ${BUILD_TYPE} STREQUAL STATIC_LIBRARY)
        add_definitions(-DBOOST_TEST_DYN_LINK)
    endif()
    add_definitions(-DBOOST_ALL_NO_LIB)


endfunction()

function(cmut_test__find_turtle)


    if(HUNTER_ENABLED)
        hunter_add_package(turtle)
    endif()

    find_package(Turtle)

    if(NOT TURTLE_FOUND)
        cmut_warn("Can't found turtle. Tests skipped.")
        return()
    endif()
    set(TURTLE_FOUND ${TURTLE_FOUND} PARENT_SCOPE)

    include_directories(${TURTLE_INCLUDE_DIR})

endfunction()


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
