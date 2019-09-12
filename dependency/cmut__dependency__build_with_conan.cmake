


function(__cmut__dependency__build_with_conan__implementation )

    cmut__lang__function__init_param(cmut__dependency__build_with_conan SKIP_UNPARSED)
    cmut__lang__function__add_param(CONAN_VERSION DEFAULT 1.17.0)
    cmut__lang__function__parse_arguments(${ARGN})


    cmut__conan__download_cmake_conan()
    include(${CMAKE_BINARY_DIR}/conan.cmake)
    conan_check(VERSION ${ARG_CONAN_VERSION} REQUIRED)

    cmut__cmake_conan__get_compiler_cppstd_setting(compiler_cppstd_setting)

    conan_cmake_run(
        ${ARGN}
        ${compiler_cppstd_setting}
        ${shared_option}
        PROFILE_AUTO ALL
        )

endfunction()


macro(cmut__dependency__build_with_conan )

    option(BUILD_DEPENDENCIES "use conan to install/build dependencies" OFF)
    set(CMUT_CONAN_PROFILE "" CACHE STRING "conan profile to use when build dependencies")

    if(BUILD_DEPENDENCIES)
        set(cmut__dependency__build_with_conan__profile)
        if(CMUT_CONAN_PROFILE)
            set(cmut__dependency__build_with_conan__profile PROFILE ${CMUT_CONAN_PROFILE})
        endif()

        __cmut__dependency__build_with_conan__implementation( ${ARGN} ${cmut__dependency__build_with_conan__profile} )
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
