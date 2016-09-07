include("${CMAKE_CURRENT_LIST_DIR}/cmut_deprecated.cmake")
cmut_deprecated("cmut_target_compile_option_cxx_version.cmake" "build/cmut__build__enable_cxx_standard.cmake")


# look for an compiler option to enable specified cxx version
function(cmut_get_compile_option_for_cxx_version version)

    if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
        CHECK_CXX_COMPILER_FLAG("-std=c++${version}" CMUT_COMPILER_SUPPORTS_CXX_VERSION)
    else()
        message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++${version} support. Please use a different C++ compiler.")
        return()
    endif()

    set(CMUT_COMPILER_OPTION_CXX_${version} "-std=c++${version}" PARENT_SCOPE)

endfunction()


# try enable specified cxx version for specified target with cmake's "target_compile_options" command.
function(cmut_target_compile_option_cxx_version target scope version)

    cmut_get_compile_option_for_cxx_version(${version})

    if (CMUT_COMPILER_OPTION_CXX_${version})
        message(STATUS "Use C++ version : ${version} for target \"${target}\".")
        target_compile_options(${target} ${scope} "${CMUT_COMPILER_OPTION_CXX_${version}}")
    endif()

endfunction()
