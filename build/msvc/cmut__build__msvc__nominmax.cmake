include(${CMAKE_CURRENT_LIST_DIR}/../../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()


function(cmut__build__msvc__nominmax target)

    cmut_deprecated_function(cmut__build__msvc__nominmax cmut__target__win32__nominmax)
    cmut__target__win32__nominmax( ${target} )

endfunction()
