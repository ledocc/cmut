include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include("${CMAKE_CURRENT_LIST_DIR}/cmut__install__install_target.cmake")


# cmut__install__install_library :
function(cmut__install__install_library target)
    cmut_warn("[cmut] - cmut__install__install_library is deprecated, use cmut__install__install_target instead")
    cmut__install__install_target( ${target} INCLUDE_DIRECTORIES "${${target}_INCLUDE_DIR}" )
endfunction()
