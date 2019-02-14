

function( cmut__cmake_conan__get_shared_options result )

    if(BUILD_SHARED_LIBS)
        cmut__lang__return_value(OPTIONS "*:shared=True")
    else()
        cmut__lang__return_value(OPTIONS "*:shared=False")
    endif()

endfunction()
