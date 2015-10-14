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

function( cmut_define_install_app_bundle_dirs target)

  if(CMAKE_HOST_APPLE)
      if(NOT CMUT_DEFINE_INSTALL_DIRS_DONE)
          cmut_define_install_dirs()
      endif()

      set(BUNDLE_ROOTDIR          ${CMUT_INSTALL_BINDIR}/${target}.app)
      set(BUNDLE_CONTENTSDIR      ${BUNDLE_ROOTDIR}/Contents)


      set(CMUT_INSTALL_BUNDLE_ROOTDIR          ${BUNDLE_ROOTDIR}                   PARENT_SCOPE)
      set(CMUT_INSTALL_BUNDLE_CONTENTSDIR      ${BUNDLE_CONTENTSDIR}               PARENT_SCOPE)
      set(CMUT_INSTALL_BUNDLE_BINDIR           ${BUNDLE_CONTENTSDIR}/MacOS         PARENT_SCOPE)
      set(CMUT_INSTALL_BUNDLE_LIBDIR           ${BUNDLE_CONTENTSDIR}/Frameworks    PARENT_SCOPE)
      set(CMUT_INSTALL_BUNDLE_RESOURCESDIR     ${BUNDLE_CONTENTSDIR}/Resources     PARENT_SCOPE)
      set(CMUT_INSTALL_BUNDLE_PLUGINSDIR       ${BUNDLE_CONTENTSDIR}/PlugIns       PARENT_SCOPE)
      set(CMUT_INSTALL_BUNDLE_SHAREDSUPPORTDIR ${BUNDLE_CONTENTSDIR}/SharedSupport PARENT_SCOPE)
      set(CMUT_INSTALL_BUNDLE_INFO_PLISTDIR    ${BUNDLE_CONTENTSDIR}               PARENT_SCOPE)
  endif()

endfunction()
