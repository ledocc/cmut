

include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



# This option control the documentation generation.
# When ON, all library will be build in shared mode,
# when OFF, all library will be build in static mode,
function(cmut__config__option_build_documentation defaultValue)

    option(BUILD_DOC "Enable this option to generate documentation" ${defaultValue})

    set(BUILD_DOC_MODE "disable")
    if(BUILD_DOC)
        set(BUILD_DOC_MODE "enable")
    endif()

    cmut_info("[cmut][config] - build documentation : ${BUILD_DOC_MODE}")

endfunction()
