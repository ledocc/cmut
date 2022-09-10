

set(CMUT_DIR "${CMAKE_CURRENT_LIST_DIR}/../..")

include("${CMUT_DIR}/utest.cmake")
include("${CMUT_DIR}/lg/property.cmake")


function(test__lg_set_cmake_property)

    lg_set_cmake_property(test__lg_set_cmake_property__var1 value1)
    get_cmake_property(result test__lg_set_cmake_property__var1)

    utest__if(result STREQUAL value1)

endfunction()

utest__begin(lg_set_cmake_property)

    test__lg_set_cmake_property()
    
utest__end()