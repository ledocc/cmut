

function(cmut__config__default_cxx_standard default_cxx_standard )

    cmut__lang__function__init_param( cmut__config__default_cxx_standard )
    cmut__lang__function__add_option( EXTENSIONS )
    cmut__lang__function__parse_arguments( ${ARGN} )

    if(NOT DEFINED CMAKE_CXX_STANDARD)

        set( with_extension_msg )
        if(ARG_EXTENSIONS)
            set( with_extension_msg " with extension")
        endif()
        if( CONAN_EXPORTED )
            cmut_info( "[cmut][config][default_cxx_standard]: Setting cxx standard to '${default_cxx_standard}${with_extension_msg}' skipped as CONAN_EXPORTED is defined." )
            return()
        endif()

        cmut_info( "[cmut][config][default_cxx_standard]: Setting cxx standard to '${default_cxx_standard}${with_extension_msg}' as none was specified." )
        set( CMAKE_CXX_STANDARD "${default_cxx_standard}" PARENT_SCOPE )
        set( CMAKE_CXX_EXTENSIONS ${ARG_EXTENSIONS} PARENT_SCOPE )

    endif()

endfunction()
