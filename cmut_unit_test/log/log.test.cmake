
include("${CMAKE_CURRENT_LIST_DIR}/../../log.cmake")

if (NOT CMUT__LOG__IS_DEBUG_ENABLE)
    message(WARNING "Debug log is disable, add -DCMUT__LOG__LEVEL=debug when invoking cmake.")
endif()


cmut__log__dev(test__log   "developer log.")
cmut__log__debug(test__log "debug log.")
cmut__log__info(test__log  "information log.")
cmut__log__warn(test__log  "warning log.")
cmut__log__error(test__log "error log.")
cmut__log__fatal(test__log "fatal error log.")
