function( cmut_define_uninstall_target )

    if(NOT CMUT_UNINSTALL_CMAKE_IN)
        find_file(CMUT_UNINSTALL_CMAKE_IN private/cmake_uninstall.cmake.in 
                  PATHS ${CMAKE_MODULE_PATH}
                  DOC "source file used to generate uninstall target"
                  NO_DEFAULT_PATH)
        mark_as_advanced(FORCE CMUT_UNINSTALL_CMAKE_IN)
#    else()
#        message("define_uninstall_target already called, skipped." )
    endif()
#-----------------------------------------------------------------------------
### uninstall target
#-----------------------------------------------------------------------------
    configure_file(
      ${CMUT_UNINSTALL_CMAKE_IN}
      "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
      IMMEDIATE @ONLY)
    add_custom_target(uninstall
      "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake")

endfunction()