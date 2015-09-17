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

      set(BUNDLE_ROOT_DIR ${CMUT_INSTALL_BINDIR}/${target}.app/Contents)

      set(BUNDLE_BINDIR           ${BUNDLE_ROOT_DIR}/MacOS)
      set(BUNDLE_LIBDIR           ${BUNDLE_ROOT_DIR}/Frameworks)

      set(CMUT_INSTALL_BUNDLE_BINDIR           ${BUNDLE_BINDIR}                 PARENT_SCOPE)
      set(CMUT_INSTALL_BUNDLE_LIBDIR           ${BUNDLE_LIBDIR}                 PARENT_SCOPE)
      set(CMUT_INSTALL_BUNDLE_RESOURCESDIR     ${BUNDLE_ROOT_DIR}/Resources     PARENT_SCOPE)
      set(CMUT_INSTALL_BUNDLE_PLUGINSDIR       ${BUNDLE_ROOT_DIR}/PlugIns       PARENT_SCOPE)
      set(CMUT_INSTALL_BUNDLE_SHAREDSUPPORTDIR ${BUNDLE_ROOT_DIR}/SharedSupport PARENT_SCOPE)
      set(CMUT_INSTALL_BUNDLE_INFO_PLISTDIR    ${BUNDLE_ROOT_DIR}               PARENT_SCOPE)
  endif()

endfunction()
