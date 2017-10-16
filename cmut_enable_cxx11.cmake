include(CheckCXXCompilerFlag)

include("${CMAKE_CURRENT_LIST_DIR}/cmut_deprecated.cmake")
cmut_deprecated("cmut_enable_cxx11.cmake" "build/cmut__build__enable_cxx_standard.cmake")


#message(CMAKE_COMPILER_IS_CLANGXX = ${CMAKE_COMPILER_IS_CLANGXX})
#if (CMAKE_COMPILER_IS_GNUCXX OR CMAKE_COMPILER_IS_CLANGXX)

if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
    CHECK_CXX_COMPILER_FLAG("-std=c++14" CMUT_COMPILER_SUPPORTS_CXX14)
    CHECK_CXX_COMPILER_FLAG("-std=c++11" CMUT_COMPILER_SUPPORTS_CXX11)
    if(CMUT_COMPILER_SUPPORTS_CXX14)
        set(CMUT_CXX_VERSION c++14)
    elseif(CMUT_COMPILER_SUPPORTS_CXX11)
        set(CMUT_CXX_VERSION c++11)
    else()
        message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
    endif()

    if (CMUT_CXX_VERSION)
        message(STATUS "Use C++ version : ${CMUT_CXX_VERSION}.")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=${CMUT_CXX_VERSION}")
    endif()

endif()
