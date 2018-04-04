include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include("${CMAKE_CURRENT_LIST_DIR}/cmut__install__define_variables.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__install__component_dependency.cmake")


# cmut__install__install_target( target [INCLUDE_DIRECTORIES include/MyLib [include/MyLib2]] )
# - install library and headers of target
# - generate and install <target name>Target.cmake
#
function(cmut__install__install_target target)

    __cmut__install__define_variables()

    # test the target
    if(NOT TARGET ${target})
        cmut_error("cmut__install__install_library : TARGET \"${target}\" not defined.")
        return()
    endif()

    cmut__utils__parse_arguments(
        cmut__install__install_library
        ARG_
        ""
        ""
        "INCLUDE_DIRECTORIES"
        ${ARGN}
        )

    # install header
    if(DEFINED ARG__INCLUDE_DIRECTORIES)
        install(
            DIRECTORY "${ARG__INCLUDE_DIRECTORIES}"
            DESTINATION "${cmut__install__include_dir}"
            COMPONENT   devel
        )
    endif()

    # install generated "export header"
    get_target_property(target_type ${target} TYPE)
    if(NOT target_type STREQUAL INTERFACE_LIBRARY)

        __cmut__install__install_generated_header(${target} CMUT__TARGET__EXPORT_HEADER)
        __cmut__install__install_generated_header(${target} CMUT__TARGET__VERSION_HEADER)

    endif()


    set(target_export_name "${target}${cmut__install__target_export_name_posfix}")


    # install lib
    install(
        TARGETS  ${target}
        EXPORT   ${target_export_name}
        ARCHIVE  DESTINATION "${cmut__install__archive_dir}"
        COMPONENT "runtime"
        LIBRARY  DESTINATION "${cmut__install__library_dir}"
        COMPONENT "runtime"
        RUNTIME  DESTINATION "${cmut__install__runtime_dir}"
        COMPONENT "runtime"
        PRIVATE_HEADER DESTINATION "${cmut__install__private_header_dir}"
        COMPONENT "devel"
        PUBLIC_HEADER  DESTINATION "${cmut__install__public_header_dir}"
        COMPONENT "devel"
        RESOURCE       DESTINATION "${cmut__install__resource_header_dir}"
        COMPONENT "devel"
        INCLUDES DESTINATION "${cmut__install__include_dir}"
        )


    if(CMUT__CONFIG__DEVELOPER_MODE)
        export(
            EXPORT ${target_export_name}
            NAMESPACE ${cmut__install__export_namespace}
            FILE "${PROJECT_BINARY_DIR}/${cmut__install__config_dir}/${target}/${target_export_name}.cmake"
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
            CMUT__INSTALL__${PROJECT_NAME}_SUPPORTED_COMPONENTS
        "${target}"
    )

    cmut__install__add_component_dependency(devel ${target})
    cmut__install__add_component_dependency(runtime ${target})

endfunction()




function(__cmut__install__install_generated_header target target_property)

    get_target_property(generated_header_path ${target} ${target_property})
    set(generated_header_filepath "${CMAKE_CURRENT_BINARY_DIR}/include/${generated_header_path}")

    if(EXISTS ${generated_header_filepath})

        get_filename_component(generated_header_dirname "${generated_header_path}" DIRECTORY)

        install(
            FILES       "${generated_header_filepath}"
            DESTINATION "${cmut__install__include_dir}/${generated_header_dirname}"
            COMPONENT   devel
            )

    endif()


endfunction()
