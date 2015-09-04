#-----------------------------------------------------------------------------
# define INSTALL_*DIR
#-----------------------------------------------------------------------------

include( cmut_determine_lib_postfix )


macro( cmut_define_install_dirs )

    if( NOT DEFINED CMUT_LIB_POSTFIX )
        cmut_determine_lib_postfix()
    endif()
    
    #-----------------------------------------------------------------------------
    # define install directory
    #-----------------------------------------------------------------------------
    set( CMUT_INSTALL_INCDIR include )
    set( CMUT_INSTALL_BINDIR bin )
    if(WIN32)
        set(CMUT_INSTALL_LIBDIR ${CMUT_INSTALL_BINDIR})
        set(CMUT_INSTALL_ARCHIVEDIR lib)
    else()
        set(CMUT_INSTALL_LIBDIR lib${CMUT_LIB_POSTFIX})
        set(CMUT_INSTALL_ARCHIVEDIR lib${CMUT_LIB_POSTFIX})
    endif()

    set(CMUT_DEFINE_INSTALL_DIRS_DONE 1)
    mark_as_advanced(CMUT_DEFINE_INSTALL_DIRS_DONE)

endmacro()