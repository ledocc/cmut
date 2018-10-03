include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)


macro(__cmut__utils__set_or_default_version_in_parent_scope project_name version_component_name value default)

    if("${value}" STREQUAL "")
        set(version_component_value ${default})
    else()
        set(version_component_value ${value})
    endif()

    set(${project_name}_${version_component_name} ${version_component_value} PARENT_SCOPE)
    set(PROJECT_${version_component_name}         ${version_component_value} PARENT_SCOPE)
    set(CMAKE_PROJECT_${version_component_name}   ${version_component_value} PARENT_SCOPE)

endmacro()

macro(__cmut__utils__parse_version name_ version_ functionName_)

    set(version_regex "([0-9]+)(\\.([0-9]+))?(\\.([0-9]+))?(\\.([0-9]+))?(-rc([0-9]+))?")

    if (NOT ${version_} MATCHES ${version_regex})
        cmut_error("${functionName_} : invalid version format : ${version_}\n")
    endif()


    __cmut__utils__set_or_default_version_in_parent_scope(${name_} VERSION                   "${version_}" 0 )
    __cmut__utils__set_or_default_version_in_parent_scope(${name_} VERSION_MAJOR             "${CMAKE_MATCH_1}" 0 )
    __cmut__utils__set_or_default_version_in_parent_scope(${name_} VERSION_MINOR             "${CMAKE_MATCH_3}" 0 )
    __cmut__utils__set_or_default_version_in_parent_scope(${name_} VERSION_PATCH             "${CMAKE_MATCH_5}" 0 )
    __cmut__utils__set_or_default_version_in_parent_scope(${name_} VERSION_TWEAK             "${CMAKE_MATCH_7}" 0 )
    __cmut__utils__set_or_default_version_in_parent_scope(${name_} VERSION_RELEASE_CANDIDATE "${CMAKE_MATCH_9}" 0 )
    __cmut__utils__set_or_default_version_in_parent_scope(${name_} RELEASE_CANDIDATE         "${CMAKE_MATCH_9}" 0 )

endmacro()




function(cmut__utils__parse_version name_ version_)

    __cmut__utils__parse_version(${name_} ${version_} cmut__utils__parse_version)

endfunction()
