
function(cmut__test__turtle__find_required_components)

    list(APPEND CMAKE_MODULE_PATH "${CMUT_FIND_MODULE_PATH}")
    find_package(Turtle REQUIRED)

    find_package(Boost REQUIRED COMPONENTS unit_test_framework)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(cmut__test__turtle__link_target target)

    if(TURTLE_INCLUDE_DIR)
        target_include_directories( ${target} PUBLIC ${TURTLE_INCLUDE_DIR} )
    endif()

    if( CMAKE_CXX_COMPILER_ID MATCHES "Clang" )
        target_compile_options( ${target} PUBLIC -Wno-gnu-zero-variadic-macro-arguments )
    endif()


    target_link_libraries( ${target} PUBLIC Boost::unit_test_framework )

endfunction()
