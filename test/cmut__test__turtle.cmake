

function(cmut__test__turtle__find_required_components)

    list(APPEND CMAKE_MODULE_PATH "${CMUT_FIND_MODULE_PATH}")
    find_package(Turtle REQUIRED)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(cmut__test__turtle__link_target target)

    target_include_directories( ${target} PUBLIC ${TURTLE_INCLUDE_DIR} )

    if( CMAKE_CXX_COMPILER_ID MATCHES "Clang" )
        target_compile_options( ${target} PUBLIC -Wno-gnu-zero-variadic-macro-arguments )
    endif()

endfunction()
