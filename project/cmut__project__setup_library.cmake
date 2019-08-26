



# cmut__project__setup_library( target [ VERSION version ]
#
function(cmut__project__setup_library target)

    get_target_property( target_type ${target} TYPE )
    if( NOT target_type MATCHES "^(.*)_LIBRARY$")
        cmut_fatal("[cmut][project][setup_library] - call on non library target : target TYPE = \"${target_type}\".")
    endif()

    set( library_type ${CMAKE_MATCH_1} )

    set(library_property_scope PUBLIC)
    if(library_type STREQUAL INTERFACE)
        set(library_property_scope INTERFACE)
    endif()



    cmut__utils__parse_arguments(
        cmut__project__setup_library
        ARG
        "CXX_EXTENSIONS;CXX_STANDARD_REQUIRED"
        "DEBUG_POSTFIX;OUTPUT_PREFIX;VERSION;WINNT_VERSION"
        "CXX_FEATURES"
        ${ARGN}
    )


    cmut__utils__set_default_argument( ARG_DEBUG_POSTFIX "d" )
    cmut__utils__set_default_argument( ARG_OUTPUT_PREFIX "${PROJECT_BINARY_DIR}" )
    cmut__utils__set_default_argument( ARG_VERSION ${PROJECT_VERSION} )
    cmut__utils__set_default_argument( ARG_WINNT_VERSION 0X601 )

    if( ARG_CXX_EXTENSIONS OR ARG_CXX_STANDARD_REQUIRED )
        cmut_warn("CXX_EXTENSIONS, CXX_STANDARD_REQUIRED should not be used for target description, use compile_features instead.")
    endif()

    if(DEFINED ARG_CXX_FEATURES)
        target_compile_features( ${target} ${library_property_scope} ${ARG_CXX_FEATURES} )
    endif()

    if( NOT target_type STREQUAL INTERFACE_LIBRARY )
        cmut__target__define_debug_postfix( ${target} ${ARG_DEBUG_POSTFIX} )
        cmut__target__define_output_directory( ${target} PREFIX "${ARG_OUTPUT_PREFIX}" )
        cmut__target__generate_export_header( ${target} "${target}/export.h" )
        cmut__target__set_library_version( ${target} ${ARG_VERSION} )
    endif()


    cmut__target__win32__nominmax( ${target} )
    cmut__target__win32__secure_no_warning( ${target} )
    cmut__target__win32__set_winnt_version( ${target} ${ARG_WINNT_VERSION} )
    cmut__target__win32__unicode( ${target} )
    cmut__target__win32__win32_lean_and_mean( ${target} )

    if( MSVC )
        set( MSVC_WARNING
            -wd4251 # disable warning about std type not exported in dll interface
            -wd4275 # disable warning about class derived from std type not exported in dll interface
        )
        target_compile_options( ${target} ${library_property_scope} ${MSVC_WARNING} )
    endif()

endfunction()
