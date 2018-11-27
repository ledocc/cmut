

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

    cmut_deprecated_function( cmut__utils__set_project_version cmut__project__set_version )
    cmut__project__set_version( ${file_path_} )

endfunction()

function(cmut__utils__set_project_version_from_file file_path_)

    cmut_deprecated_function(cmut__utils__set_project_version_from_file cmut__project__set_version_from_file)
    cmut__project__set_version_from_file( ${file_path_} )

endfunction()
