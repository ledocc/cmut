# from Eric Scott Barr
# http://ericscottbarr.com/blog/2015/06/driving-boost-dot-test-with-cmake/

# conveniant function to add boost test

include(CMakePrintHelpers)
include("${CMAKE_CURRENT_LIST_DIR}/cmut__find.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__test.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__target.cmake")

function(cmut__test__get_required_boost_components result)

    set(components
        chrono
        timer
        unit_test_framework
        )
    set(${result} "${components}" PARENT_SCOPE)

endfunction()


cmut__test__get_required_boost_components( CMUT_TEST__BOOST_TEST_COMPONENTS )


function(cmut_test__find_boost_test version)

    cmut__test__get_required_boost_components(boost_test_components)
    find_package(
        Boost ${version}
        REQUIRED COMPONENTS
            ${boost_test_components}
        )

    if(NOT Boost_UNIT_TEST_FRAMEWORK_FOUND)
        cmut_warn("[cmut][test][boost_test] - Can't found boost::unit_test_framework. Tests skipped.")
        return()
    endif()
    set(Boost_UNIT_TEST_FRAMEWORK_FOUND ${Boost_UNIT_TEST_FRAMEWORK_FOUND} PARENT_SCOPE)

    foreach(component ${boost_test_components})
        link_libraries( Boost::${component} )
    endforeach()


    get_target_property(BUILD_TYPE Boost::unit_test_framework TYPE)
    if(NOT ${BUILD_TYPE} STREQUAL STATIC_LIBRARY)
        add_definitions(-DBOOST_TEST_DYN_LINK)
    endif()
    add_definitions(-DBOOST_ALL_NO_LIB)


    if( MSVC )
        cmut__target__append_property(Boost::unit_test_framework INTERFACE_COMPILE_OPTIONS -wd4389 )
    endif()

endfunction()


function(cmut_test__find_turtle)

    if(HUNTER_ENABLED)
        hunter_add_package(turtle)
    endif()

    list(APPEND CMAKE_MODULE_PATH "${CMUT_FIND_MODULE_PATH}")
    find_package(Turtle)

    if(NOT TURTLE_FOUND)
        cmut_warn("Can't found turtle. Tests skipped.")
        return()
    endif()
    set(TURTLE_FOUND ${TURTLE_FOUND} PARENT_SCOPE)

    include_directories(${TURTLE_INCLUDE_DIR})

    if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        add_compile_options( -Wno-gnu-zero-variadic-macro-arguments )
    endif()

endfunction()



function(cmut_add_boost_test namespace test_src_file)

    cmut__test__make_test_name(${namespace} ${test_src_file} name)
    if(NOT Boost_UNIT_TEST_FRAMEWORK_FOUND)
        cmut_info("[cmut][test][boost_test] - ${name} skipped.")
        return()
    endif()

    add_executable(${name} ${test_src_file} ${ARGN})

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
        cmut_add_boost_test(${namespace} ${file} "")
    endforeach()

endfunction()

function(cmut_add_boost_test_single namespace test_source)

    #message("add test ${test_source}")
    cmut_add_boost_test(${namespace} ${test_source} ${ARGN})

endfunction()
