

macro(cmut_set_version LibName version)

    set(CMUT_BUILD_${LibName}_VERSION ${version} CACHE STRING "${LibName} version to build")

endmacro()

macro(cmut_set_default_final_prefix LibName Value)

    if(NOT CMUT_BUILD_${LibName}_INSTALL_FINAL_PREFIX)
        set(CMUT_BUILD_${LibName}_INSTALL_FINAL_PREFIX ${Value} CACHE PATH "directory add to CMAKE_INSTALL_PREFIX to define final installation prefix" FORCE)
    endif()
    
endmacro()

macro(cmut_set_final_prefix LibName)

    set(CMUT_BUILD_${LibName}_INSTALL_FINAL_PREFIX CACHE PATH "directory add to CMAKE_INSTALL_PREFIX to define final installation prefix")
    mark_as_advanced(CMUT_BUILD_${LibName}_INSTALL_FINAL_PREFIX)

    set(CMUT_BUILD_${LibName}_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})

    if (CMUT_BUILD_${LibName}_INSTALL_FINAL_PREFIX)
        set(CMUT_BUILD_${LibName}_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}/${CMUT_BUILD_${LibName}_INSTALL_FINAL_PREFIX})
    endif()

endmacro()
