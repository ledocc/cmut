include("${CMAKE_CURRENT_LIST_DIR}/../../target/cmut__target__append_property.cmake")

function(cmut__package__boost__disable_warning target)

    if(MSVC)
        cmut__target__append_property(${target} INTERFACE_COMPILE_OPTIONS
            -wd4127
            -wd4244
            -wd4503
            -wd4512
            -wd4714)
    endif()

endfunction()
