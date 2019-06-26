
function( cmut__cmake_conan__get_compiler_cppstd_setting result )

    if( DEFINED CMAKE_CXX_STANDARD )
        set( cppstd ${CMAKE_CXX_STANDARD} )
        if( CMAKE_CXX_EXTENSION )
            set( cppstd "${cppstd}gnu" )
        endif()
    endif()

    cmut__lang__return_value( SETTINGS "compiler.cppstd=${cppstd}" )

endfunction()
