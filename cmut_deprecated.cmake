include("${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__header_guard.cmake")
cmut__utils__define_header_guard()


include("${CMAKE_CURRENT_LIST_DIR}/cmut_message.cmake")
function(cmut_deprecated old new)
    cmut_warn("cmut file \"${old}\" is deprecated, prefer \"${new}\" instead")
endfunction()
