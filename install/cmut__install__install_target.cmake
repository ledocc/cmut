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
        cmut_error("[cmut][install][install_target] : TARGET \"${target}\" not defined.")
        return()
    endif()

    cmut__utils__parse_arguments(
        cmut__install__install_library
        ARG_
        ""
        "HEADER_COMPONENT;COMPONENT"
        "INCLUDE_DIRECTORIES"
        ${ARGN}
        )
    if(NOT ARG__HEADER_COMPONENT)
        set(ARG__HEADER_COMPONENT devel)
    endif()
    if(NOT ARG__COMPONENT)
        set(ARG__COMPONENT runtime)
    endif()



    # install header
    if(DEFINED ARG__INCLUDE_DIRECTORIES)
        install(
            DIRECTORY   "${ARG__INCLUDE_DIRECTORIES}"
            DESTINATION "${cmut__install__include_dir}"
            COMPONENT   ${ARG__HEADER_COMPONENT}
        )
    endif()

    # install generated "export header"
    get_target_property(target_type ${target} TYPE)
    if((target_type STREQUAL SHARED_LIBRARY) OR (target_type STREQUAL STATIC_LIBRARY))

        __cmut__install__install_generated_header(${target} CMUT__TARGET__EXPORT_HEADER)
        __cmut__install__install_generated_header(${target} CMUT__TARGET__FORWARD_HEADER)
        __cmut__install__install_generated_header(${target} CMUT__TARGET__VERSION_HEADER)

    endif()


    set(target_export_name "${target}${cmut__install__target_export_name_posfix}")


    # install lib
    install(
        TARGETS  ${target}
        EXPORT   ${target_export_name}
        ARCHIVE  DESTINATION "${cmut__install__archive_dir}"
        COMPONENT "${ARG__COMPONENT}"
        LIBRARY  DESTINATION "${cmut__install__library_dir}"
        COMPONENT "${ARG__COMPONENT}"
        RUNTIME  DESTINATION "${cmut__install__runtime_dir}"
        COMPONENT "${ARG__COMPONENT}"
        FRAMEWORK DESTINATION "${cmut__install__framework_dir}"
        COMPONENT "${ARG__COMPONENT}"
        BUNDLE DESTINATION "${cmut__install__bundle_dir}"
        COMPONENT "${ARG__COMPONENT}"
        PRIVATE_HEADER DESTINATION "${cmut__install__private_header_dir}"
        COMPONENT "devel"
        PUBLIC_HEADER  DESTINATION "${cmut__install__public_header_dir}"
        COMPONENT "devel"
        RESOURCE       DESTINATION "${cmut__install__resource_header_dir}"
        COMPONENT "devel"
        INCLUDES DESTINATION "${cmut__install__include_dir}"
        )

    if( (target_type STREQUAL SHARED_LIBRARY)
            OR (target_type STREQUAL STATIC_LIBRARY)
            OR (target_type STREQUAL INTERFACE_LIBRARY) )

        __cmut__install__export_library()
        cmut__install__add_component_dependencies(devel ${target})

    endif()

    set_property(
        GLOBAL
        APPEND
        PROPERTY
            CMUT__INSTALL__${PROJECT_NAME}_SUPPORTED_COMPONENTS
        "${target}"
    )

    cmut__install__add_component_dependencies(${ARG__COMPONENT} ${target})

endfunction()



function(__cmut__install__export_library)

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

endfunction()



function(__cmut__install__install_generated_header target target_property)

    get_target_property(generated_header_path ${target} ${target_property})
    if (NOT generated_header_path)
        return()
    endif()

    foreach(filepath IN LISTS generated_header_path)

        set(generated_header_filepath "${CMAKE_CURRENT_BINARY_DIR}/include/${filepath}")

        if(EXISTS "${generated_header_filepath}")

            get_filename_component(generated_header_dirname "${filepath}" DIRECTORY)

            install(
                FILES       "${generated_header_filepath}"
                DESTINATION "${cmut__install__include_dir}/${generated_header_dirname}"
                COMPONENT   devel
                )

        endif()

    endforeach()

endfunction()
