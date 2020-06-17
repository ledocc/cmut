

## cmut__conan__download_cmake_conan( [VERSION version] [OUTPUT_PATH path-where-save-conan.cmake])
## download https://github.com/conan-io/cmake-conan/conan.cmake
##
## VERSION specify a version to download, default is 0.13
## OUTPUT_PATH specify the file path where save conan.cmake, default is ${CMAKE_BINARY_DIR}/conan.cmake


function( cmut__conan__get_cmake_conan_sha256 result version )

    set( CMUT__CONAN__CMAKE_CONAN_SHA256__0_14 "c9c8dfaf21fb071aa1cd2a2e250b73476405705052096e4cdfd5f1192b007dd0" )
    set( CMUT__CONAN__CMAKE_CONAN_SHA256__0_15 "75c92be7d739ab69c3c9a1cd0bf4728cd08da143a18776eb43f8e2af16accace" )

    string(REPLACE "." "_" version_with_underscore ${version} )
    cmut__lang__return( SHA256__${version_with_underscore} )

endfunction()


function( cmut__conan__download_cmake_conan )

    cmut__lang__function__init_param(cmut__conan__download_cmake_conan)
    cmut__lang__function__add_param(VERSION DEFAULT 0.15)
    cmut__lang__function__add_param(OUTPUT_PATH DEFAULT "${PROJECT_BINARY_DIR}/conan.cmake")
    cmut__lang__function__parse_arguments(${ARGN})

    cmut__conan__get_cmake_conan_sha256( cmake_conan_sha256 ${ARG_VERSION} )

    if(EXISTS "${ARG_OUTPUT_PATH}")
        if(NOT cmake_conan_sha256)
            return()
        endif()
        file(SHA256 "${ARG_OUTPUT_PATH}" hash)
        if(hash STREQUAL ${cmake_conan_sha256})
            return()
        endif()
    endif()

    if(cmake_conan_sha256)
        set( expected_hash_opt EXPECTED_HASH SHA256=${cmake_conan_sha256} )
    endif()

    cmut_info("Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
    file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/v${ARG_VERSION}/conan.cmake"
        ${ARG_OUTPUT_PATH}
        ${expected_hash_opt}
        TLS_VERIFY ON
        )

endfunction()
