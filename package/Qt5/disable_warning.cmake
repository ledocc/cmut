include("${CMAKE_CURRENT_LIST_DIR}/../../target/cmut__target__append_property.cmake")

function(cmut__package__Qt5__disable_warning target)

    if(MSVC)
        libunoQt__target__append_property(${target} INTERFACE_COMPILE_OPTIONS
            -wd4127
            )
    endif()

endfunction()
