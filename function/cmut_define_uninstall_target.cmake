function( cmut_define_uninstall_target )

    if(NOT CMUT_UNINSTALL_CMAKE_IN)

        message("CMAKE_CURRENT_LIST_FILE = ${CMAKE_CURRENT_LIST_FILE}")
        message("CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")


        find_file(CMUT_UNINSTALL_CMAKE_IN cmake_uninstall.cmake.in
                  PATHS ${CMAKE_CURRENT_LIST_DIR}/private
                  DOC "source file used to generate uninstall target"
                  NO_DEFAULT_PATH)
        if(CMUT_UNINSTALL_CMAKE_IN)
            mark_as_advanced(FORCE CMUT_UNINSTALL_CMAKE_IN)
        else()
            cmut_error("cmake_uninstall.cmake.in not found.")
        endif()
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