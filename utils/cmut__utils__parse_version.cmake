include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)


macro(__cmut__utils__set_or_default_in_parent_scope name value default)
    if("${value}" STREQUAL "")
        set(${name} ${default} PARENT_SCOPE)
    else()
        set(${name} ${value} PARENT_SCOPE)
    endif()
endmacro()

macro(__cmut__utils__parse_version name_ version_ functionName_)

    set(version_regex "([0-9]+)(\\.([0-9]+))?(\\.([0-9]+))?(\\.([0-9]+))?(-rc([0-9]+))?")

    if (NOT ${version_} MATCHES ${version_regex})
        cmut_error("${functionName_} : invalid version format : ${version_}\n")
    endif()


    __cmut__utils__set_or_default_in_parent_scope(${name_}_VERSION_MAJOR     "${CMAKE_MATCH_1}" 0 PARENT_SCOPE)
    __cmut__utils__set_or_default_in_parent_scope(${name_}_VERSION_MINOR     "${CMAKE_MATCH_3}" 0 PARENT_SCOPE)
    __cmut__utils__set_or_default_in_parent_scope(${name_}_VERSION_PATCH     "${CMAKE_MATCH_5}" 0 PARENT_SCOPE)
    __cmut__utils__set_or_default_in_parent_scope(${name_}_VERSION_TWEAK     "${CMAKE_MATCH_7}" 0 PARENT_SCOPE)
    __cmut__utils__set_or_default_in_parent_scope(${name_}_RELEASE_CANDIDATE "${CMAKE_MATCH_9}" 0 PARENT_SCOPE)

endmacro()




function(cmut__utils__parse_version name_ version_)

    __cmut__utils__parse_version(${name_} ${version_} cmut__utils__parse_version)

endfunction()
