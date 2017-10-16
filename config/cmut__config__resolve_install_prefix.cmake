

function(cmut__config__resolve_install_prefix)

    if(IS_ABSOLUTE "${CMAKE_INSTALL_PREFIX}")
        return()
    endif()

    set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_PREFIX}" CACHE PATH "" FORCE)

endfunction()
