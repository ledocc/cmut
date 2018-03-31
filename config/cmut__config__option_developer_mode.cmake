include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



# This option is to enable the CMUT__CONFIG__DEVELOPER_MODE that set :
# - CMAKE_EXPORT_NO_PACKAGE_REGISTRY to OFF
# - register the project build tree in "cmake's User Package Registry"
# - install config.cmake files in build tree to be used by other package
# -
function(cmut__config__option_developer_mode)

    option(CMUT__CONFIG__DEVELOPER_MODE "Set to ON to install/export Config file in build tree." OFF)
    cmut_info("[cmut][config] - Developer mode is ${CMUT__CONFIG__DEVELOPER_MODE}")

endfunction()
