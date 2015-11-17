

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

    set(CMUT_EP_${LibName}_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})

    if (CMUT_EP_${LibName}_FINAL_INSTALL_PREFIX)
        set(CMUT_EP_${LibName}_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}/${CMUT_EP_${LibName}_FINAL_INSTALL_PREFIX})
    endif()

endmacro()
