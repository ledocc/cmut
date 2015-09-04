#------------------------------------------------------------------------------
# determine the LIB_POSTFIX variable
#------------------------------------------------------------------------------


macro( CMUT_DETERMINE_LIB_POSTFIX )

    if(CMAKE_SIZEOF_VOID_P MATCHES "8")

        set(SYSTEM_ARCHITECTURE "64bits")

	if(UNIX AND NOT WIN32 AND NOT APPLE)
            set(CMUT_LIB_POSTFIX "64")
        endif()

    else(CMAKE_SIZEOF_VOID_P MATCHES "8")

        set(SYSTEM_ARCHITECTURE "32bits")
        set(CMUT_LIB_POSTFIX "")

    endif()


    mark_as_advanced(CMUT_LIB_POSTFIX)

    
endmacro()