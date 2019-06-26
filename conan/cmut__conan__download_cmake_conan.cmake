

## cmut__conan__download_cmake_conan( [VERSION version] [OUTPUT_PATH path-where-save-conan.cmake])
## download https://github.com/conan-io/cmake-conan/conan.cmake
##
## VERSION specify a version to download, default is 0.13
## OUTPUT_PATH specify the file path where save conan.cmake, default is ${CMAKE_BINARY_DIR}/conan.cmake

function( cmut__conan__download_cmake_conan )

    cmut__utils__parse_arguments(
        cmut__conan__download_cmake_conan
        ARG
        ""
        "VERSION;OUTPUT_PATH"
        ""
        ${ARGN}
        )


    cmut__utils__set_default_argument(ARG_VERSION 0.14)
    cmut__utils__set_default_argument(ARG_OUTPUT_PATH ${CMAKE_BINARY_DIR}/conan.cmake)


    if(NOT EXISTS "${ARG_OUTPUT_PATH}")
        cmut_info("Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
        file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/v${ARG_VERSION}/conan.cmake"
            "${ARG_OUTPUT_PATH}")
    endif()

endfunction()
