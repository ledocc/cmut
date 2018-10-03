

include("${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__utils__parse_version.cmake")



macro(__cmut__utils__set_version name_ version_ functionName)

    __cmut__utils__parse_version(${name_} ${version_} ${functionName})

    cmut_info("${name_} version : ${version_}")

endmacro()


########################################################################################################################

function(cmut__utils__set_version name_ version_)

    __cmut__utils__set_version(${name_} ${version_} cmut__utils__set_version)

endfunction()

function(cmut__utils__set_project_version version_)

    __cmut__utils__set_version(${PROJECT_NAME} ${version_} cmut__utils__set_project_version)

endfunction()

function(cmut__utils__set_project_version_from_file file_path_)

    if(NOT EXISTS "${file_path_}")
        cmut_fatal("[cmut][utils][set_project_version_from_file] ${file_path_} : no such file")
    endif()

    file(STRINGS "${file_path_}" version LIMIT_COUNT 1)

    __cmut__utils__set_version(${PROJECT_NAME} ${version} cmut__utils__set_project_version_from_file)

endfunction()
