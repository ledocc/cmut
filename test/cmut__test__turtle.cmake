
function(cmut__test__turtle__find_required_components)

    list(APPEND CMAKE_MODULE_PATH "${CMUT_FIND_MODULE_PATH}")
    find_package(Turtle REQUIRED)

    find_package(Boost REQUIRED COMPONENTS unit_test_framework)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(cmut__test__turtle__link_target target)

    target_link_libraries( ${target}
        PUBLIC
            Boost::unit_test_framework
            turtle::turtle
    )

endfunction()
