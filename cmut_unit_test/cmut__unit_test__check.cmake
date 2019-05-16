
macro(cmut__unit_test__check test_name)

    get_filename_component(filename "${CMAKE_CURRENT_LIST_FILE}" NAME)

    if( ${ARGN} )
        message(STATUS "${filename} \"${test_name}\" ==>> OK" )
    else()
        message(WARNING "${filename}:${CMAKE_CURRENT_LIST_LINE} \"${test_name}\" ==>> failed" )
    endif()

endmacro()
