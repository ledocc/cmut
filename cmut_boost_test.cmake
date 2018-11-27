# from Eric Scott Barr
# http://ericscottbarr.com/blog/2015/06/driving-boost-dot-test-with-cmake/

# conveniant function to add boost test

include(CMakePrintHelpers)
include("${CMAKE_CURRENT_LIST_DIR}/cmut__find.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__test.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__target.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/test/cmut__test__boost.cmake")

cmut__test__boost__get_required_components( CMUT_TEST__BOOST_TEST_COMPONENTS )


function(cmut_test__find_boost_test version)

    cmut_deprecated_function("cmut_test__find_boost_test" "cmut__test__boost__find_required_components")

    cmut__test__boost__get_required_components( components )
    cmut__test__boost__find_required_components( ${version} )

    set(Boost_UNIT_TEST_FRAMEWORK_FOUND 1 PARENT_SCOPE)

    foreach(component IN LISTS components)
        link_libraries( Boost::${component} )
    endforeach()

    get_target_property(BUILD_TYPE Boost::unit_test_framework TYPE)
    if(NOT ${BUILD_TYPE} STREQUAL STATIC_LIBRARY)
        add_definitions(-DBOOST_TEST_DYN_LINK)
    endif()
    add_definitions(-DBOOST_ALL_NO_LIB)

endfunction()


function(cmut_test__find_turtle)

    cmut_deprecated_function("cmut_test__find_turtle" "cmut__test__turtle__find_required_components")

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

    cmut_deprecated_function("cmut_add_boost_test" "cmut__test__boost__add_test")
    cmut__test__boost__add_test(${namespace} ${test_src_file} ${ARGN})

endfunction()

function(cmut_add_boost_tests namespace)

    cmut_deprecated_function("cmut_add_boost_tests" "cmut__test__boost__add_tests")
    cmut__test__boost__add_tests( ${namespace} ${ARGN} )

endfunction()

function(cmut_add_boost_test_single namespace test_source)

    #message("add test ${test_source}")
    cmut_add_boost_test(${namespace} ${test_source} ${ARGN})

endfunction()
