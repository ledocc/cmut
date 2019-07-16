
function( cmut__cmake_conan__get_compiler_cppstd_setting result )

    if( NOT DEFINED CMAKE_CXX_STANDARD )
        return()
    endif()

    set( cppstd ${CMAKE_CXX_STANDARD} )
    set( compiler_with_extension Clang GNU )
    if( ( CMAKE_CXX_EXTENSIONS ) AND ( CMAKE_CXX_COMPILER_ID IN_LIST compiler_with_extension ) )
        set( cppstd "gnu${cppstd}" )
    endif()

    cmut__lang__return_value( SETTINGS "compiler.cppstd=${cppstd}" )

endfunction()
