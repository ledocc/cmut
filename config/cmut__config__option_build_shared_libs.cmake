

include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



# This option control the link type.
# When ON, all library will be build in shared mode,
# when OFF, all library will be build in static mode,
function(cmut__config__option_build_shared_libs defaultValue)

    option(BUILD_SHARED_LIBS "Enable this option to create shared libraries" ${defaultValue})
    if(BUILD_SHARED_LIBS)
        set(CMUT__CONFIG__LINK_TYPE "shared")
    else()
        set(CMUT__CONFIG__LINK_TYPE "static")
    endif()
    cmut_info("[cmut][config] - library link type : ${CMUT__CONFIG__LINK_TYPE}")

endfunction()
