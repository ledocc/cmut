

## cmut__install__install_system_library( libName DESTINATION dir/path/to/install  [COMPONENT component])
##
## search and install library "libName"
## DESTINATION : directory path where install "libName"
## COMPONENT   : component of this install
##
function(cmut__install__install_system_library libName)

    cmut__utils__parse_arguments(
        cmut__install__install_libstdcxx
        ARG
        ""
        "DESTINATION;COMPONENT"
        ""
        ${ARGN}
        )

    if(NOT ARG_DESTINATION)
        cmut_error("[cmut][install][install_system_library] - DESTINATION parameter is required.")
        return()
    endif()

    if(NOT ARG_COMPONENT)
        set(ARG_COMPONENT)
    endif()



    find_library( libName_${libName} NAMES ${libName} )

    if(NOT libName_${libName})
        cmut_error("[cmut][install][install_system_library] - \"${libName}\" library not found.")
    endif()


    set(files_to_install "${libName_${libName}}")
    get_filename_component( libName_REALPATH "${libName_${libName}}" REALPATH )
    if( NOT "${libName_REALPATH}" STREQUAL "${libName_${libName}}" )
        list(APPEND files_to_install "${libName_REALPATH}")
    endif()

    install(FILES
        ${files_to_install}
        DESTINATION "${ARG_DESTINATION}"
        COMPONENT ${ARG_COMPONENT}
        )

endfunction()
