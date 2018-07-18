

function(cmut__utils__cmake_cxx_standard_to_compiler_option result)

    set( option )

    if( CMAKE_CXX_STANDARD )

        if( MSVC )
            if (MSVC_VERSION GREATER_EQUAL "1900")
                if( CMAKE_CXX_STANDARD GREATER_EQUAL 14 )
                    set(option /std=c++${CMAKE_CXX_STANDARD})
                endif()
	    endif()
        elseif(    ( CMAKE_CXX_COMPILER_ID STREQUAL "GNU" ) 
                OR (CMAKE_CXX_COMPILER_ID STREQUAL "Clang") 
                OR (CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang") )
            if( CMAKE_CXX_EXTENSION )
                set(option -std=gnu${CMAKE_CXX_STANDARD})
            else()
                set(option -std=c++${CMAKE_CXX_STANDARD})
            endif()
        else()
            cmut_warn("[cmut][utils] - cmake_cxx_standard_to_compiler_option : compiler \"${CMAKE_CXX_COMPILER_ID}\" not supported by this script. Patch me if you can!")
        endif()

    endif()

    set( ${result} ${option} PARENT_SCOPE )

endfunction()