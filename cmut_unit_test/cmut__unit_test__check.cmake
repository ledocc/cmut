

set(CMUT_UNIT_TEST__ROOT_DIR ${CMAKE_CURRENT_LIST_DIR})


macro(cmut__unit_test__check test_name lhs op rhs)

    file( RELATIVE_PATH filepath "${CMUT_UNIT_TEST__ROOT_DIR}" "${CMAKE_CURRENT_LIST_FILE}")

#    message(STATUS "if( \"${lhs}\" ${op} \"${rhs}\" )")
    if( "${lhs}" ${op} "${rhs}" )
        message( STATUS "${filepath} \"${test_name}\" ==>> OK" )
    else()
        message( WARNING "${filepath}:${CMAKE_CURRENT_LIST_LINE} \"${test_name}\" ==>> failed" )
    endif()

endmacro()

