
function(__cmut__conan__define_and_collect_list_var result var_name var_msg default)
    set( CMUT__CONAN__${var} "" CACHE STRING ${var_msg} )

    set(values ${default})
    if(NOT "${CMUT__CONAN__${var_name}_LIST}" STREQUAL "")
        set(values ${CMUT__CONAN__${var_name}_LIST})
    endif()

    unset(opt)
    foreach( value IN LISTS values )
        list( APPEND opt ${var_name} ${value} )
    endforeach()

    cmut__lang__return( opt )
endfunction()

macro(__cmut__conan__define_and_collect_var result var_name var_msg default)
    set( CMUT__CONAN__${var} "" CACHE STRING ${var_msg} )

    set(values ${default})
    if(NOT "${CMUT__CONAN__${var_name}}" STREQUAL "")
        set(values ${CMUT__CONAN__${var_name}_LIST})
    endif()

    cmut__lang__return( values )
endmacro()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function( __cmut__conan__get_profile_opt result profiles)
    if(DEFINED CMUT_CONAN_PROFILE)
        cmut_deprecated_variable(CMUT_CONAN_PROFILE CMUT__CONAN__PROFILE_LIST)
        set(CMUT__CONAN__PROFILE_LIST ${CMUT_CONAN_PROFILE})
    endif()

    if(DEFINED CMUT__CONAN__PROFILES)
        cmut_deprecated_variable(CMUT__CONAN__PROFILES CMUT__CONAN__PROFILE_LIST)
        set(CMUT__CONAN__PROFILE_LIST ${CMUT__CONAN__PROFILES})
    endif()

    __cmut__conan__define_and_collect_list_var(opt PROFILE "conan profile list to use when build dependencies" "${profiles}" )
    cmut__lang__return( opt )
endfunction()

function( __cmut__conan__get_profile_build_opt result profiles)
    __cmut__conan__define_and_collect_list_var(opt PROFILE_BUILD "conan profile_build list to use when build dependencies" "${profiles}" )
    cmut__lang__return( opt )
endfunction()

function( __cmut__conan__get_profile_host_opt result profiles)
    __cmut__conan__define_and_collect_list_var(opt PROFILE_HOST "conan profile_host list to use when build dependencies" "${profiles}" )
    cmut__lang__return( opt )
endfunction()

function( __cmut__conan__get_option_opt result options)
    __cmut__conan__define_and_collect_list_var(opt OPTION "conan option list to use when build dependencies" "${options}" )
    cmut__lang__return( opt )
endfunction()

function( __cmut__conan__get_option_build_opt result options)
    __cmut__conan__define_and_collect_list_var(opt OPTION_BUILD "conan option_build list to use when build dependencies" "${options}" )
    cmut__lang__return( opt )
endfunction()

function( __cmut__conan__get_option_host_opt result options)
    __cmut__conan__define_and_collect_list_var(opt OPTION_HOST "conan option_host list to use when build dependencies" "${options}" )
    cmut__lang__return( opt )
endfunction()

function( __cmut__conan__get_settings_opt result settings)
    __cmut__conan__define_and_collect_list_var(opt SETTINGS "conan settings list to use when build dependencies" "${settings}" )
    cmut__lang__return( opt )
endfunction()

function( __cmut__conan__get_settings_build_opt result settings)
    __cmut__conan__define_and_collect_list_var(opt SETTINGS_BUILD "conan settings_build list to use when build dependencies" "${settings}" )
    cmut__lang__return( opt )
endfunction()

function( __cmut__conan__get_settings_host_opt result settings)
    __cmut__conan__define_and_collect_list_var(opt SETTINGS_HOST "conan settings_host list to use when build dependencies" "${settings}" )
    cmut__lang__return( opt )
endfunction()

function( __cmut__conan__get_build_policies_opt result build_policies )
    __cmut__conan__define_and_collect_list_var(opt BUILD "conan build policies to use when build dependencies" "${build_policies}" )
    cmut__lang__return( opt )
endfunction()

function(__cmut__conan__select_opt result opt_simple opt_build opt_host)
    if(opt_build OR opt_host)
        set(opt ${opt_build} ${opt_host})
    else()
        set(opt ${opt_simple})
    endif()
    cmut__lang__return( opt )
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##


function( cmut__conan__build )

    cmut__lang__function__init_param(cmut__dependency__build_with_conan)
    cmut__lang__function__add_param(CONAN_VERSION DEFAULT 1.26.0)
    cmut__lang__function__add_param(CMAKE_CONAN_VERSION DEFAULT 0.16.1)
    cmut__lang__function__add_param(CONANFILE DEFAULT conanfile.py)
    cmut__lang__function__add_multi_param(BUILD DEFAULT outdated)
    cmut__lang__function__add_multi_param(PROFILE)
    cmut__lang__function__add_multi_param(PROFILE_BUILD)
    cmut__lang__function__add_multi_param(PROFILE_HOST)
    cmut__lang__function__add_multi_param(OPTIONS)
    cmut__lang__function__add_multi_param(OPTIONS_BUILD)
    cmut__lang__function__add_multi_param(OPTIONS_HOST)
    cmut__lang__function__add_multi_param(SETTINGS)
    cmut__lang__function__add_multi_param(SETTINGS_BUILD)
    cmut__lang__function__add_multi_param(SETTINGS_HOST)
    cmut__lang__function__parse_arguments(${ARGN})


    set(cmake_conan_path "${PROJECT_BINARY_DIR}/conan.cmake")
    if (ARG_CMAKE_CONAN_VERSION VERSION_LESS 0.16.0)
        cmut__log__fatal( cmut__conan__build "CMAKE_CONAN_VERSION=${ARG_CMAKE_CONAN_VERSION}: version 0.16.0 or greater is required.")
    endif()
    cmut__conan__download_cmake_conan( VERSION ${ARG_CMAKE_CONAN_VERSION} OUTPUT_PATH ${cmake_conan_path})
    include(${cmake_conan_path})
    conan_check(VERSION ${ARG_CONAN_VERSION} REQUIRED)


    __cmut__conan__get_build_policies_opt( build_policies_opt "${ARG_BUILD}" )
    __cmut__conan__get_profile_opt(       profiles_opt       "${ARG_PROFILE}" )
    __cmut__conan__get_profile_build_opt( profiles_build_opt "${ARG_PROFILE_BUILD}" )
    __cmut__conan__get_profile_host_opt(  profiles_host_opt  "${ARG_PROFILE_HOST}" )
    __cmut__conan__get_settings_opt(       settings_opt       "${ARG_SETTING}" )
    __cmut__conan__get_settings_build_opt( settings_build_opt "${ARG_SETTING_BUILD}" )
    __cmut__conan__get_settings_host_opt(  settings_host_opt  "${ARG_SETTING_HOST}" )
    __cmut__conan__get_option_opt(       options_opt       "${ARG_OPTION}" )
    __cmut__conan__get_option_build_opt( options_build_opt "${ARG_OPTION_BUILD}" )
    __cmut__conan__get_option_host_opt(  options_host_opt  "${ARG_OPTION_HOST}"  )


    __cmut__conan__select_opt(profiles_opt "${profiles_opt}" "${profiles_build_opt}" "${profiles_host_opt}")
    __cmut__conan__select_opt(settings_opt "${settings_opt}" "${settings_build_opt}" "${settings_host_opt}")
    __cmut__conan__select_opt(options_opt  "${options_opt}"  "${options_build_opt}"  "${options_host_opt}")

    if (DEFINED CMUT__CONFIG__OPTION_NO_AUTODETECT AND CMUT__CONFIG__OPTION_NO_AUTODETECT)
        set(extra_settings_opt "")
    else ()
        conan_cmake_autodetect(autodetected_settings)
        set(extra_settings_opt SETTINGS ${autodetected_settings})
    endif ()

    cmut__log__debug(${CMAKE_CURRENT_FUNCTION}
"
conan_cmake_install(
    PATH_OR_REFERENCE ${ARG_CONANFILE}
    ${build_policies_opt}
    ${profiles_opt}
    ${settings_opt}
    ${options_opt}
    ${build_type_opt}
    ${extra_settings_opt}
    )"
)
    conan_cmake_install(
        PATH_OR_REFERENCE ${ARG_CONANFILE}
        ${build_policies_opt}
        ${profiles_opt}
        ${settings_opt}
        ${options_opt}
        ${build_type_opt}
        ${extra_settings_opt}
        )

endfunction()
