include(${CMAKE_CURRENT_LIST_DIR}/../../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



function(cmut__build__msvc__stdc_limit_macros target)

    cmut_deprecated_function(cmut__build__msvc__stdc_limit_macros cmut__target__win32__stdc_limit_macros)
    cmut__target__win32__stdc_limit_macros( ${target} )

endfunction()
