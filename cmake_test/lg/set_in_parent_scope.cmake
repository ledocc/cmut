

set(CMUT_DIR "${CMAKE_CURRENT_LIST_DIR}/../..")

include("${CMUT_DIR}/utest.cmake")
include("${CMUT_DIR}/lg/set_in_parent_scope.cmake")


function(test__lg_set_in_parent_scope__set_single_value)
    function(test__lg_set_in_parent_scope__in)
        lg_set_in_parent_scope(var1 value1)
    endfunction()

    test__lg_set_in_parent_scope__in()
    utest__if( var1 STREQUAL value1 )

endfunction()

function(test__lg_set_in_parent_scope__set_multi_value)

    set(value1_2 value1 value2)
    function(test__lg_set_in_parent_scope__in)
        lg_set_in_parent_scope(var2 ${value1_2})
    endfunction()

    test__lg_set_in_parent_scope__in()
    utest__if( var2 STREQUAL value1_2 )

endfunction()


utest__begin(lg_return)

    test__lg_set_in_parent_scope__set_single_value()
    test__lg_set_in_parent_scope__set_multi_value()

utest__end()
