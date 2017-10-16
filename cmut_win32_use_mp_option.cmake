#------------------------------------------------------------------------------
# specifique WIN32 and MSVC option
# define option WIN32_USE_MP to build with /MP option 
#------------------------------------------------------------------------------

include("${CMAKE_CURRENT_LIST_DIR}/cmut_deprecated.cmake")
cmut_deprecated("cmut_win32_use_mp_option.cmake" "build/msvc/cmut__build__msvc__option_use_mp.cmake")


macro( CMUT_WIN32_USE_MP_OPTION )

    if(CMAKE_HOST_WIN32 AND MSVC)
        # This option is to enable the /MP switch for Visual Studio 2005 and above compilers
        option(CMUT_WIN32_USE_MP "Set to ON to build with the /MP option (Visual Studio 2005 and above)." ON)
        mark_as_advanced(CMUT_WIN32_USE_MP)

        if(CMUT_WIN32_USE_MP)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
        endif()

    endif()

endmacro()
      