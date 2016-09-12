include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include(${CMAKE_CURRENT_LIST_DIR}/cmut__install__define_variables.cmake)



# cmut__install__install_library :
# - install library and headers of target
# - generate and install <target name>Target.cmake
#
function(cmut__install__install_library target)

    __cmut__install__define_variables()


    # test the target
    if(NOT TARGET ${target})
        cmut_error("cmut__install__install_library : TARGET \"${target}\" not defined.")
        return()
    endif()


    # install header
    install(
        DIRECTORY   "${${target}_INCLUDE_DIR}"
        DESTINATION "${cmut__install__include_dir}"
        COMPONENT   devel
    )


    # install generated "export header"
    set(target_export_filepath "${CMAKE_CURRENT_BINARY_DIR}/${target}_export.h")
    if (EXISTS ${target_export_filepath})
        install(
            FILES       "${target_export_filepath}"
            DESTINATION "${cmut__install__include_dir}/${target}"
            COMPONENT   devel
        )
    endif()


    set(target_export_name "${target}${cmut__install__target_export_name_posfix}")

    # install lib
    install(
        TARGETS  ${target}
        EXPORT   ${target_export_name}
        ARCHIVE  DESTINATION "${cmut__install__archive_dir}"
        LIBRARY  DESTINATION "${cmut__install__library_dir}"
        RUNTIME  DESTINATION "${cmut__install__runtime_dir}"
        INCLUDES DESTINATION "${cmut__install__include_dir}"
        )


    if(CMUT__CONFIG__DEVELOPER_MODE)
        message("install ${CMAKE_BINARY_DIR}/${cmut__install__config_dir}/${target}/${target_export_name}.cmake")
        export(
            EXPORT ${target_export_name}
            NAMESPACE ${cmut__install__export_namespace}
            FILE "${CMAKE_BINARY_DIR}/${cmut__install__config_dir}/${target}/${target_export_name}.cmake"
        )
    endif()

    # install export file
    install(
        EXPORT "${target_export_name}"
        NAMESPACE "${cmut__install__export_namespace}"
        DESTINATION "${cmut__install__config_dir}/${target}"
        COMPONENT devel
    )

    set_property(
        GLOBAL
        APPEND
        PROPERTY
            CMUT__INSTALL_PROJECT_SUPPORTED_COMPONENTS
        "${target}"
    )


    
endfunction()


