
set(CMUT_ROOT "${CMAKE_CURRENT_LIST_DIR}")

include("${CMUT_ROOT}/cmut_message.cmake")
include("${CMUT_ROOT}/cmut_version.cmake")

if(NOT CMUT__MAIN_INCLUDE_QUIET)
    cmut_info("[cmut] - location : \"${CMUT_ROOT}\".")
    cmut_info("[cmut] - version  : \"${CMUT_VERSION}\".")
endif()

include("${CMUT_ROOT}/cmut__build.cmake")
include("${CMUT_ROOT}/cmut__config.cmake")
include("${CMUT_ROOT}/cmut__find.cmake")
include("${CMUT_ROOT}/cmut__install.cmake")
include("${CMUT_ROOT}/cmut__package.cmake")
include("${CMUT_ROOT}/cmut__qt5.cmake")
include("${CMUT_ROOT}/cmut__utils.cmake")
include("${CMUT_ROOT}/cmut__system.cmake")
include("${CMUT_ROOT}/cmut__target.cmake")
include("${CMUT_ROOT}/cmut__test.cmake")

include("${CMUT_ROOT}/cmut_deprecated.cmake")
