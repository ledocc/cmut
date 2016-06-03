

macro(cmut_define_EP_build_option LibName)

    option(CMUT_EP_BUILD_${LibName} OFF "Enable build of ${LibName}")
    
endmacro()

macro(cmut_define_EP_version LibName version)

    set(CMUT_EP_${LibName}_VERSION ${version} CACHE STRING "${LibName} version to build")

endmacro()

macro(cmut_set_EP_default_final_install_prefix LibName Value)
    
    if(CMUT_EP_BUILD_${LibName} AND (NOT CMUT_EP_${LibName}_FINAL_INSTALL_PREFIX))
        set(CMUT_EP_${LibName}_FINAL_INSTALL_PREFIX ${Value} CACHE PATH "directory add to CMAKE_INSTALL_PREFIX to define final installation prefix" FORCE)
    endif()
    
endmacro()

macro(cmut_define_EP_final_install_prefix LibName)

    set(CMUT_EP_${LibName}_FINAL_INSTALL_PREFIX CACHE PATH "directory add to CMAKE_INSTALL_PREFIX to define final installation prefix")
    mark_as_advanced(CMUT_EP_${LibName}_FINAL_INSTALL_PREFIX)

    get_filename_component(_ABSOLUTE_CMAKE_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX} ABSOLUTE)

    set(CMUT_EP_${LibName}_INSTALL_PREFIX ${_ABSOLUTE_CMAKE_INSTALL_PREFIX})

    if (CMUT_EP_${LibName}_FINAL_INSTALL_PREFIX)
        set(CMUT_EP_${LibName}_INSTALL_PREFIX ${_ABSOLUTE_CMAKE_INSTALL_PREFIX}/${CMUT_EP_${LibName}_FINAL_INSTALL_PREFIX})
    endif()

endmacro()

macro(cmut_EP_add_variable_if_defined __list __variable)
    if(${__variable})
        list(APPEND ${__list} "-D${__variable}=${${__variable}}")
    endif()
endmacro()


function(cmut_EP_collect_cmake_variable resultVariable)

    set(__cmake_vars)

    cmut_EP_add_variable_if_defined(__cmake_vars BUILD_SHARED_LIBS)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_INSTALL_PREFIX)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_BUILD_TYPE)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_PREFIX_PATH)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_VERBOSE_MAKEFILE)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_INSTALL_RPATH)

    set(${resultVariable} ${__cmake_vars} PARENT_SCOPE)

endfunction()