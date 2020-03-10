
include("${CMAKE_CURRENT_LIST_DIR}/../log.cmake")



function(cmut__project__log_version)

    cmut__log__info(cmut__project__log_version "PROJECT_VERSION            = ${PROJECT_VERSION}")
    cmut__log__info(cmut__project__log_version "PROJECT_VERSION_MAJOR      = ${PROJECT_VERSION_MAJOR}")
    cmut__log__info(cmut__project__log_version "PROJECT_VERSION_MINOR      = ${PROJECT_VERSION_MINOR}")
    cmut__log__info(cmut__project__log_version "PROJECT_VERSION_PATCH      = ${PROJECT_VERSION_PATCH}")
    cmut__log__info(cmut__project__log_version "PROJECT_VERSION_PREREALESE = ${PROJECT_VERSION_PRERELEASE}")
    cmut__log__info(cmut__project__log_version "PROJECT_VERSION_BUILD      = ${PROJECT_VERSION_BUILD}")

endfunction()
