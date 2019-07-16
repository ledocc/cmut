


function(__cmut__dependency__build_with_conan__implementation )

    cmut__lang__function__init_param(cmut__dependency__build_with_conan)
    cmut__lang__function__add_param(DEFAULT_CXX_STANDARD)
    cmut__lang__function__add_param(CONAN_VERSION DEFAULT 1.17.0)
    cmut__lang__function__parse_arguments(${ARGN})


    if(ARG_DEFAULT_CXX_STANDARD)
        cmut__lang__set_default(CMAKE_CXX_STANDARD ${ARG_DEFAULT_CXX_STANDARD})
    endif()

    cmut__conan__download_cmake_conan()
    include(${CMAKE_BINARY_DIR}/conan.cmake)
    conan_check(VERSION ${ARG_CONAN_VERSION} REQUIRED)

    cmut__cmake_conan__get_shared_option(shared_option)
    cmut__cmake_conan__get_compiler_cppstd_setting(compiler_cppstd_setting)

    conan_cmake_run(
        CONANFILE conanfile.py
        BUILD missing
        ${compiler_cppstd_setting}
        ${shared_option}
        )

endfunction()


macro(cmut__dependency__build_with_conan )

    option(BUILD_DEPENDENCIES "use conan to install/build dependencies" OFF)

    if(BUILD_DEPENDENCIES)
        __cmut__dependency__build_with_conan__implementation( ${ARGN} )
    endif()

    if( BUILD_DEPENDENCIES OR CONAN_EXPORTED )
        include( "${PROJECT_BINARY_DIR}/conan_paths.cmake" )
        if( CONAN_EXPORTED )
            include( "${PROJECT_BINARY_DIR}/conanbuildinfo.cmake" )
            conan_check_compiler()
            conan_set_libcxx()
            conan_set_std()
            conan_set_vs_runtime()

        endif()
    endif()

endmacro()
