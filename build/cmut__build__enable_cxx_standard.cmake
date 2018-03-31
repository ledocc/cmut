include( "${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake" )
cmut__utils__define_header_guard()


include( "${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__parse_arguments.cmake" )


function(cmut__build__enable_cxx_standard version)

    cmut__utils__parse_arguments(
        cmut__build__enable_cxx_standard
        ARG_
        "CXX_EXTENSIONS"
        ""
        ""
        ${ARGN}
    )

    set(CMAKE_CXX_EXTENSIONS ${ARG__CXX_EXTENSIONS} PARENT_SCOPE)
    set(CMAKE_CXX_STANDARD ${version} PARENT_SCOPE)
    set(CMAKE_CXX_STANDARD_REQUIRED ON PARENT_SCOPE)

endfunction()
