

macro(set_version LibName version)

    set(${LibName}_VERSION ${version} CACHE STRING "${LibName} version to build")

endmacro()

macro(set_final_prefix LibName)

    set(${LibName}_INSTALL_FINAL_PREFIX CACHE PATH "directory add to CMAKE_INSTALL_PREFIX to define final installation prefix")
    mark_as_advanced(${LibName}_INSTALL_FINAL_PREFIX)

    set(${LibName}_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})

    if (${LibName}_INSTALL_FINAL_PREFIX)
        set(${LibName}_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}/${${LibName}_INSTALL_FINAL_PREFIX})
    endif()

endmacro()
