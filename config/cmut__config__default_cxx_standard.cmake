

function(cmut__config__default_cxx_standard default_cxx_standard )

    cmut__lang__function__init_param( cmut__config__default_cxx_standard )
    cmut__lang__function__add_param( EXTENSIONS )
    cmut__lang__function__parse_arguments( ${ARGN} )

    if(NOT DEFINED CMAKE_CXX_STANDARD)
        cmut_info( "Setting cxx standard to '${default_cxx_standard}' as none was specified." )
        set( CMAKE_CXX_STANDARD "${default_cxx_standard}" )
        set( CMAKE_CXX_EXTENSIONS ${EXTENSIONS} )
    endif()

endfunction()
