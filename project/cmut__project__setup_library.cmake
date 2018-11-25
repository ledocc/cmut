



# cmut__project__setup_library( target [ VERSION version ]
#
function(cmut__project__setup_library target)

    cmut__utils__parse_arguments(
        cmut__project__setup_library
        ARG
        "CXX_EXTENSIONS;CXX_STANDARD_REQUIRED"
        "DEBUG_POSTFIX;OUTPUT_PREFIX;VERSION;WINNT_VERSION"
        ""
        ${ARGN}
        )

    if(DEFINED CMAKE_CXX_STANDARD)
        cmut__utils__set_default_argument( ARG_CXX_STANDARD ${CMAKE_CXX_STANDARD} )
    endif()
    cmut__utils__set_cmake_or_default_argument( ARG_CXX_EXTENSIONS CMAKE_CXX_EXTENSIONS FALSE)
    cmut__utils__set_cmake_or_default_argument( ARG_CXX_STANDARD_REQUIRED CMAKE_CXX_STANDARD_REQUIRED TRUE)

    cmut__utils__set_default_argument( ARG_DEBUG_POSTFIX "d" )
    cmut__utils__set_default_argument( ARG_OUTPUT_PREFIX "${PROJECT_BINARY_DIR}" )
    cmut__utils__set_default_argument( ARG_VERSION ${PROJECT_VERSION} )
    cmut__utils__set_default_argument( ARG_WINNT_VERSION 0X601 )


    if(DEFINED ARG_CXX_STANDARD)
        if(ARG_CXX_EXTENSIONS)
            list( APPEND define_cxx_standard__ARGS EXTENSIONS )
        endif()
        if(ARG_CXX_STANDARD_REQUIRED)
            list( APPEND define_cxx_standard__ARGS REQUIRED )
        endif()
        cmut__target__define_cxx_standard( ${target} ${ARG_CXX_STANDARD} ${define_cxx_standard__ARGS} )
    endif()
    cmut__target__define_debug_postfix( ${target} ${ARG_DEBUG_POSTFIX} )
    cmut__target__define_output_directory( ${target} PREFIX "${ARG_OUTPUT_PREFIX}" )
    cmut__target__generate_export_header( ${target} "${target}/export.h" )
    cmut__target__set_library_version( ${target} ${ARG_VERSION} )

    cmut__target__win32__nominmax( ${target} )
    cmut__target__win32__secure_no_warning( ${target} )
    cmut__target__win32__set_winnt_version( ${target} ${ARG_WINNT_VERSION} )
    cmut__target__win32__unicode( ${target} )
    cmut__target__win32__win32_lean_and_mean( ${target} )


    target_include_directories(
        ${target}
        PUBLIC
            "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
            "$<INSTALL_INTERFACE:$<INSTALL_PREFIX>/include>"
        )


    if( MSVC )
        set( MSVC_WARNING
            -wd4251 # disable warning about std type not exported in dll interface
            -wd4275 # disable warning about class derived from std type not exported in dll interface
        )
        target_compile_options( ${target} PUBLIC ${MSVC_WARNING} )
    endif()

endfunction()
