include("${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__header_guard.cmake")
cmut__utils__define_header_guard()



function(__cmut_deprecated_message type old new)
    cmut_warn("cmut ${type} \"${old}\" is deprecated, prefer \"${new}\" instead")
endfunction()

include("${CMAKE_CURRENT_LIST_DIR}/cmut_message.cmake")
function(cmut_deprecated old new)
    __cmut_deprecated_message( file "${old}" "${new}" )
endfunction()

function(cmut_deprecated_function old new)
    __cmut_deprecated_message( function "${old}" "${new}" )
endfunction()

function(cmut_deprecated_variable old new)
    __cmut_deprecated_message( variable "${old}" "${new}" )
endfunction()

function(cmut_deprecated_env_variable old new)
    __cmut_deprecated_message( "environment variable" "${old}" "${new}" )
endfunction()
