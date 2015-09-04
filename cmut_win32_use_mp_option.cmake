#------------------------------------------------------------------------------
# specifique WIN32 and MSVC option
# define option WIN32_USE_MP to build with /MP option 
#------------------------------------------------------------------------------

macro( CMUT_WIN32_USE_MP_OPTION )

    if(WIN32 AND MSVC)
        # This option is to enable the /MP switch for Visual Studio 2005 and above compilers
        option(CMUT_WIN32_USE_MP "Set to ON to build with the /MP option (Visual Studio 2005 and above)." OFF)
        mark_as_advanced(CMUT_WIN32_USE_MP)

        if(CMUT_WIN32_USE_MP)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
        endif()

    endif()

endmacro()
      