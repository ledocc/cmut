include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)


function(cmut__utils__parse_version version __major __minor __patch)

    set(version_regex_component_content "[0-9A-Za-z-]")
    set(version_regex_component "${version_regex_component_content}+")
    set(version_regex_separator "\\.")
    
    set(TWO_PART_VERSION_REGEX "${version_regex_component}${version_regex_separator}${version_regex_component}")
    set(THREE_PART_VERSION_REGEX "${TWO_PART_VERSION_REGEX}${version_regex_separator}${version_regex_component}")

    if(${version} MATCHES ${THREE_PART_VERSION_REGEX})
        string(REGEX REPLACE "^(${version_regex_component})${version_regex_separator}${version_regex_component}${version_regex_separator}${version_regex_component}" "\\1" __major_version "${version}")
        string(REGEX REPLACE "^${version_regex_component}${version_regex_separator}(${version_regex_component})${version_regex_separator}${version_regex_component}" "\\1" __minor_version "${version}")
        string(REGEX REPLACE "^${version_regex_component}${version_regex_separator}${version_regex_component}${version_regex_separator}(${version_regex_component})" "\\1" __patch_version "${version}")
    elseif(${version} MATCHES ${TWO_PART_VERSION_REGEX})
        string(REGEX REPLACE "^(${version_regex_component})${version_regex_separator}${version_regex_component}" "\\1" __major_version "${version}")
        string(REGEX REPLACE "^${version_regex_component}${version_regex_separator}(${version_regex_component})" "\\1" __minor_version "${version}")
        set(${__patch_version} 0)
    else()
        cmut_error("cmut__utils__parse_version: fail to parse version \"${version}\"")
        return()
    endif()


    set(${__major} ${__major_version} PARENT_SCOPE)
    set(${__minor} ${__minor_version} PARENT_SCOPE)
    set(${__patch} ${__patch_version} PARENT_SCOPE)

    
endfunction()
