

include("${CMAKE_CURRENT_LIST_DIR}/cmut_deprecated.cmake")
cmut_deprecated("cmut_enable_runpath.cmake" "build/cmut__build__enable_runpath_link.cmake")

# on unix except apple, add linker flag to use RUNPATH instead of depretiated RPATH

if((CMAKE_HOST_UNIX) AND (NOT CMAKE_HOST_APPLE))

    set(CMUT_LINKER_FLAGS_USE_RUNPATH "-Wl,--enable-new-dtags")
    message(STATUS "Use RUNPATH instead of deprecated RPATH.")

    macro(__cmut_add_runpath_linker_flags LINK_TYPE)
        set(CMAKE_${LINK_TYPE}_LINKER_FLAGS "${CMAKE_${LINK_TYPE}_LINKER_FLAGS} ${CMUT_LINKER_FLAGS_USE_RUNPATH}")
        list(REMOVE_DUPLICATES CMAKE_${LINK_TYPE}_LINKER_FLAGS)
    endmacro()

    __cmut_add_runpath_linker_flags(EXE)
    __cmut_add_runpath_linker_flags(SHARED)
    __cmut_add_runpath_linker_flags(MODULE)
    
endif()
