
include( "${CMAKE_CURRENT_LIST_DIR}/../cmut__unit_test__check.cmake" )
include( "${CMAKE_CURRENT_LIST_DIR}/../../lang/set_default.cmake" )


function(cmut__unit_test__lang__set_default__already_defined)

    set( TEST_VARIABLE 5 )
    cmut__lang__set_default( TEST_VARIABLE 50 )

    cmut__unit_test__check( already_defined ${TEST_VARIABLE} EQUAL 5 )

endfunction()

function(cmut__unit_test__lang__set_default__happy_path)

    unset( TEST_VARIABLE )
    cmut__lang__set_default( TEST_VARIABLE 50 )

    cmut__unit_test__check( happy_path ${TEST_VARIABLE} EQUAL 50 )

endfunction()


cmut__unit_test__lang__set_default__already_defined()
cmut__unit_test__lang__set_default__happy_path()
