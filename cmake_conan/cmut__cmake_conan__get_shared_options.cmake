
function( cmut__cmake_conan__get_shared_options result )
    cmut_deprecated_function( cmut__cmake_conan__get_shared_options cmut__cmake_conan__get_shared_option )

    cmut__cmake_conan__get_shared_option( result_tmp )
    cmut__lang__return( result_tmp )

endfunction()


function( cmut__cmake_conan__get_shared_option result )

    if(BUILD_SHARED_LIBS)
        cmut__lang__return_value(OPTIONS "*:shared=True")
    else()
        cmut__lang__return_value(OPTIONS "*:shared=False")
    endif()

endfunction()
