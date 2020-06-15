
function( __cmut__conan__get_profiles_opt result profiles )
    set( CMUT__CONAN__PROFILES "" CACHE STRING "conan profile list to use when build dependencies" )

    set(opt)
    foreach( profile IN LISTS CMUT_CONAN_PROFILE CMUT__CONAN__PROFILES profiles )
        list( APPEND opt PROFILE ${profile} )
    endforeach()
    cmut__lang__return( opt )

endfunction()

function( __cmut__conan__get_build_policies_opt result build_policies )
    set(CMUT__CONAN__BUILD_POLICIES "" CACHE STRING "conan build policy list to use when build dependencies")

    set(opt)
    foreach( build_policy IN LISTS CMUT__CONAN__BUILD_POLICIES build_policies )
        list( APPEND opt BUILD ${build_policy} )
    endforeach()
    cmut__lang__return( opt )

endfunction()

function( __cmut__conan__get_options_opt result options )
    set(CMUT__CONAN__OPTIONS "" CACHE STRING "conan option list to use when build dependencies")

    set(opt)
    foreach( option IN LISTS CMUT__CONAN__OPTIONS options )
        list( APPEND opt OPTIONS ${option} )
    endforeach()
    cmut__lang__return( opt )

endfunction()





function( cmut__conan__build )
    cmut__lang__function__init_param(cmut__dependency__build_with_conan)
    cmut__lang__function__add_param(CONAN_VERSION DEFAULT 1.26.0)
    cmut__lang__function__add_param(CMAKE_CONAN_VERSION DEFAULT 0.15)
    cmut__lang__function__add_param(CONANFILE DEFAULT conanfile.py)
    cmut__lang__function__add_param(DEFAULT_BUILD_TYPE DEFAULT Release)
    cmut__lang__function__add_multi_param(BUILD_POLICY DEFAULT outdated)
    cmut__lang__function__add_multi_param(PROFILE)
    cmut__lang__function__add_multi_param(OPTIONS)
    cmut__lang__function__parse_arguments(${ARGN})

    set(cmake_conan_path "${PROJECT_BINARY_DIR}/conan.cmake")
    cmut__conan__download_cmake_conan( VERSION ${ARG_CMAKE_CONAN_VERSION} OUTPUT_PATH ${cmake_conan_path})
    include(${cmake_conan_path})
    conan_check(VERSION ${ARG_CONAN_VERSION} REQUIRED)

    __cmut__conan__get_profiles_opt( profiles_opt "${ARG_PROFILE}" )
    __cmut__conan__get_build_policies_opt( build_policies_opt "${ARG_BUILD_POLICY}" )
    __cmut__conan__get_options_opt( options_opt "${ARG_OPTIONS}" )

    set(CONAN_BUILD_TYPES Debug Release RelWithDebInfo MinSizeRel)
    if(NOT CMAKE_BUILD_TYPE IN_LIST CONAN_BUILD_TYPES)
        set(build_type_opt BUILD_TYPE ${ARG_DEFAULT_BUILD_TYPE})
        cmut__log__info(cmut__conan__build "invalid build type for conan: \"${CMAKE_BUILD_TYPE}\", use \"${ARG_DEFAULT_BUILD_TYPE}\" instead.")
    endif()

    conan_cmake_run(
        CONANFILE ${ARG_CONANFILE}
        ${build_policies_opt}
        ${profiles_opt}
        ${options_opt}
        ${build_type_opt}
        PROFILE_AUTO ALL
        )

endfunction()
