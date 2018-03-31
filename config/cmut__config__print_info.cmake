

function(cmut__config__print_cmake_info)

    cmut_info("[cmut][config] - ================================================================================")
    cmut_info("[cmut][config] - CMake informations :")
    cmut_info("[cmut][config] - ")
    cmut_info("[cmut][config] - CMAKE_COMMAND : ${CMAKE_COMMAND}")
    cmut_info("[cmut][config] - CMAKE_VERSION : ${CMAKE_VERSION}")
    cmut_info("[cmut][config] - ================================================================================")

endfunction()


function(cmut__config__print_build_info)

    cmut_info("[cmut][config] - ================================================================================")
    cmut_info("[cmut][config] - Build informations :")
    cmut_info("[cmut][config] - ")
    cmut_info("[cmut][config] - CMAKE_GENERATOR          : ${CMAKE_GENERATOR}")
    if(CMAKE_GENERATOR_PLATFORM)
        cmut_info("[cmut][config] - CMAKE_GENERATOR_PLATFORM : ${CMAKE_GENERATOR_PLATFORM}")
    endif()
    if(CMAKE_GENERATOR_TOOLSET)
        cmut_info("[cmut][config] - CMAKE_GENERATOR_TOOLSET  : ${CMAKE_GENERATOR_TOOLSET}")
    endif()
    if(CMAKE_TOOLCHAIN_FILE)
        cmut_info("[cmut][config] - CMAKE_TOOLCHAIN_FILE     : ${CMAKE_TOOLCHAIN_FILE}")
    endif()
    cmut_info("[cmut][config] - ================================================================================")

endfunction()


function(cmut__config__print_system_info)

    cmut_info("[cmut][config] - ================================================================================")
    cmut_info("[cmut][config] - System informations :")
    cmut_info("[cmut][config] - ")
    cmut_info("[cmut][config] - CMAKE_SYSTEM_NAME      : ${CMAKE_SYSTEM_NAME}")
    cmut_info("[cmut][config] - CMAKE_SYSTEM_VERSION   : ${CMAKE_SYSTEM_VERSION}")
    cmut_info("[cmut][config] - CMAKE_SYSTEM_PROCESSOR : ${CMAKE_SYSTEM_PROCESSOR}")
    if(CMAKE_SYSROOT)
        cmut_info("[cmut][config] - CMAKE_SYSROOT          : ${CMAKE_SYSROOT}")
    endif()
    if(CMAKE_STAGING_PREFIX)
        cmut_info("[cmut][config] - CMAKE_STAGING_PREFIX   : ${CMAKE_STAGING_PREFIX}")
    endif()
    cmut_info("[cmut][config] - ================================================================================")

endfunction()


function(cmut__config__print_info)

    cmut__config__print_cmake_info()
    cmut__config__print_system_info()
    cmut__config__print_build_info()

endfunction()
