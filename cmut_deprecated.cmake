include("${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__header_guard.cmake")
cmut__utils__define_header_guard()

include("${CMAKE_CURRENT_LIST_DIR}/cmut_message.cmake")

function(cmut_deprecated_message what replacement)
    if("$ENV{CMUT__DISABLE_DEPRECATED_WARNING}" STREQUAL "")
        cmut_warn("cmut ${what} is deprecated, prefer ${replacement} instead")
    endif()
endfunction()

########################################################################################################################
########################################################################################################################
########################################################################################################################

function(cmut_deprecated_message__private type old new)
    cmut_deprecated_message("${type} \"${old}\"" "\"${new}\"")
endfunction()

########################################################################################################################

function(cmut_deprecated old new)
    cmut_deprecated_message__private( "file" "${old}" "${new}" )
endfunction()

function(cmut_deprecated_function old new)
    cmut_deprecated_message__private( "function" "${old}" "${new}" )
endfunction()

function(cmut_deprecated_variable old new)
    cmut_deprecated_message__private( "variable" "${old}" "${new}" )
endfunction()

function(cmut_deprecated_env_variable old new)
    cmut_deprecated_message__private( "environment variable" "${old}" "${new}" )
endfunction()

function(cmut_deprecated_parameter old new)
    cmut_deprecated_message__private( "parameter" "${old}" "${new}" )
endfunction()
