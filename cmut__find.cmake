
set(CMUT_FIND_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/find")
list(APPEND CMAKE_MODULE_PATH "${CMUT_FIND_MODULE_PATH}")

include("${CMAKE_CURRENT_LIST_DIR}/find/cmut__find__import_target.cmake")
