

function(cmut__config__print_cmake_info)

    cmut__log__info(cmut__config__print_info "================================================================================")
    cmut__log__info(cmut__config__print_info "CMake informations :")
    cmut__log__info(cmut__config__print_info "")
    cmut__log__info(cmut__config__print_info "CMAKE_COMMAND : ${CMAKE_COMMAND}")
    cmut__log__info(cmut__config__print_info "CMAKE_VERSION : ${CMAKE_VERSION}")
    cmut__log__info(cmut__config__print_info "================================================================================")

endfunction()


function(cmut__config__print_build_info)

    cmut__log__info(cmut__config__print_info "================================================================================")
    cmut__log__info(cmut__config__print_info "Build informations :")
    cmut__log__info(cmut__config__print_info "")
    cmut__log__info(cmut__config__print_info "CMAKE_GENERATOR          : ${CMAKE_GENERATOR}")
    if(CMAKE_GENERATOR_PLATFORM)
        cmut__log__info(cmut__config__print_info "CMAKE_GENERATOR_PLATFORM : ${CMAKE_GENERATOR_PLATFORM}")
    endif()
    if(CMAKE_GENERATOR_TOOLSET)
        cmut__log__info(cmut__config__print_info "CMAKE_GENERATOR_TOOLSET  : ${CMAKE_GENERATOR_TOOLSET}")
    endif()
    if(CMAKE_TOOLCHAIN_FILE)
        cmut__log__info(cmut__config__print_info "CMAKE_TOOLCHAIN_FILE     : ${CMAKE_TOOLCHAIN_FILE}")
    endif()
    cmut__log__info(cmut__config__print_info "================================================================================")

endfunction()


function(cmut__config__print_system_info)

    cmut__log__info(cmut__config__print_info "================================================================================")
    cmut__log__info(cmut__config__print_info "System informations :")
    cmut__log__info(cmut__config__print_info "")
    cmut__log__info(cmut__config__print_info "CMAKE_SYSTEM_NAME      : ${CMAKE_SYSTEM_NAME}")
    cmut__log__info(cmut__config__print_info "CMAKE_SYSTEM_VERSION   : ${CMAKE_SYSTEM_VERSION}")
    cmut__log__info(cmut__config__print_info "CMAKE_SYSTEM_PROCESSOR : ${CMAKE_SYSTEM_PROCESSOR}")
    if(CMAKE_SYSROOT)
        cmut__log__info(cmut__config__print_info "CMAKE_SYSROOT          : ${CMAKE_SYSROOT}")
    endif()
    if(CMAKE_STAGING_PREFIX)
        cmut__log__info(cmut__config__print_info "CMAKE_STAGING_PREFIX   : ${CMAKE_STAGING_PREFIX}")
    endif()
    cmut__log__info(cmut__config__print_info "================================================================================")

endfunction()


function(cmut__config__print_info)

    cmut__config__print_cmake_info()
    cmut__config__print_system_info()
    cmut__config__print_build_info()

endfunction()
