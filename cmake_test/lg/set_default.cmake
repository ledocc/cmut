

set(CMUT_DIR "${CMAKE_CURRENT_LIST_DIR}/../..")

include("${CMUT_DIR}/utest.cmake")
include("${CMUT_DIR}/lg/set_default.cmake")


function(test__lg_set_default__set_unseted_value)

    unset(var1)
    lg_set_default(var1 default_value1)

    utest__if(var1 STREQUAL default_value1)

endfunction()

function(test__lg_set_default__set_seted_value)

    set(var2 value2)
    lg_set_default(var2 default_value2)

    utest__if(var2 STREQUAL value2)

endfunction()

utest__begin(lg_return)

    test__lg_set_default__set_unseted_value()
    test__lg_set_default__set_seted_value()

utest__end()
