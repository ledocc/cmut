

set(CMUT_DIR "${CMAKE_CURRENT_LIST_DIR}/../..")

include("${CMUT_DIR}/utest.cmake")
include("${CMUT_DIR}/lg/return.cmake")


function(test__lg_return)
    function(test__lg_return_in result)
        set(var1 value1)
        lg_return(var1)
        set(${result} value2 PARENT_SCOPE)
    endfunction()

    test__lg_return_in(returned_value)
    utest__if(returned_value STREQUAL value1)
    
endfunction()

function(test__lg_return_value)
    function(test__lg_return_value_in result)
        lg_return_value(value1)
        set(${result} value2 PARENT_SCOPE)
    endfunction()

    test__lg_return_value_in(returned_value)
    utest__if(returned_value STREQUAL value1)
    
endfunction()

function(test__lg_return_unset)
    function(test__lg_return_unset_in result)
        set(${result} value2 PARENT_SCOPE)
        lg_return_unset()
        set(${result} value2 PARENT_SCOPE)
    endfunction()

    test__lg_return_unset_in(returned_value)
    utest__if(NOT DEFINED returned_value)
    
endfunction()


utest__begin(lg_return)

    test__lg_return()
    test__lg_return_value()
    test__lg_return_unset()
    
utest__end()
