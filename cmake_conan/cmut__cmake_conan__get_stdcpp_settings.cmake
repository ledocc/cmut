
function( cmut__cmake_conan__get_cppstd_settings result )

    if( DEFINED CMAKE_CXX_STANDARD )
        set( cppstd ${CMAKE_CXX_STANDARD} )
        if( CMAKE_CXX_EXTENSION )
            set( cppstd "${cppstd}gnu" )
        endif()
    endif()

    cmut__lang__return_value( SETTINGS "cppstd=${cppstd}" )

endfunction()
