

include("${CMAKE_CURRENT_LIST_DIR}/cmut_message.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut_version.cmake")

if(NOT CMUT__MAIN_INCLUDE_QUIET)
    cmut_info("[cmut] - location : \"${CMUT_ROOT}\".")
    cmut_info("[cmut] - version  : \"${CMUT_VERSION}\".")
endif()

include("${CMAKE_CURRENT_LIST_DIR}/cmut__build.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__config.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__find.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__install.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__utils.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__system.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__target.cmake")
