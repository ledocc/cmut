include(${CMAKE_CURRENT_LIST_DIR}/../../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



function(cmut__build__msvc__secure_no_warning target)

    cmut_deprecated_function(cmut__build__msvc__secure_no_warning cmut__target__win32__secure_no_warning)
    cmut__target__win32__secure_no_warning( ${target} )

endfunction()
