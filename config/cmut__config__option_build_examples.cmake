include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()


function(cmut__config__option_build_examples defaultValue)

    option(BUILD_EXAMPLES "Enable this option to build examples" ${defaultValue})
    cmut_info("[cmut][config] - build example : ${BUILD_EXAMPLES}")

endfunction()
