
# cmut__install__target( target
#                        [COMPONENT component]
#                        [HEADERS_COMPONENT component]
# - install library and headers of target
# - generate and install <target name>Target.cmake
#
function(cmut__install__target target)

    # test the target
    if(NOT TARGET ${target})
        cmut__log__error( cmut__install__target "TARGET \"${target}\" not defined.")
        return()
    endif()


    cmut__lang__function__init_param( cmut__install__install_target )
    cmut__lang__function__add_param( COMPONENT          DEFAULT runtime )
    cmut__lang__function__add_param( HEADERS_COMPONENT DEFAULT devel )
    cmut__lang__function__add_param( INCLUDES_COMPONENT )
    cmut__lang__function__add_multi_param( INCLUDE_DIRECTORIES )
    cmut__lang__function__parse_arguments( ${ARGN} )

    if(DEFINED ARG_INCLUDES_COMPONENT)
        cmut_deprecated_parameter( INCLUDES_COMPONENT HEADERS_COMPONENT )
        set( ARG_HEADERS_COMPONENT  "${ARG_INCLUDES_COMPONENT}" )
    endif()

    if(DEFINED ARG_INCLUDE_DIRECTORIES)
        cmut_deprecated_parameter( INCLUDE_DIRECTORIES "cmut__target__set_{public,private}_header_directories" )
        cmut__target__set_public_header_directories( ${target} "${ARG_INCLUDE_DIRECTORIES}" )
    endif()


    set( library_target_type SHARED_LIBRARY STATIC_LIBRARY INTERFACE_LIBRARY )
    get_target_property(target_type ${target} TYPE)
    __cmut__install__define_variables()


    # install target
    install(
        TARGETS  ${target}
        EXPORT   ${target}
        ARCHIVE  DESTINATION "${cmut__install__archive_dir}"
        COMPONENT "${ARG_COMPONENT}"
        LIBRARY  DESTINATION "${cmut__install__library_dir}"
        COMPONENT "${ARG_COMPONENT}"
        RUNTIME  DESTINATION "${cmut__install__runtime_dir}"
        COMPONENT "${ARG_COMPONENT}"
        FRAMEWORK DESTINATION "${cmut__install__framework_dir}"
        COMPONENT "${ARG_COMPONENT}"
        BUNDLE DESTINATION "${cmut__install__bundle_dir}"
        COMPONENT "${ARG_COMPONENT}"
        PRIVATE_HEADER DESTINATION "${cmut__install__private_header_dir}"
        COMPONENT "${ARG_HEADERS_COMPONENT}"
        PUBLIC_HEADER  DESTINATION "${cmut__install__public_header_dir}"
        COMPONENT "${ARG_HEADERS_COMPONENT}"
        RESOURCE       DESTINATION "${cmut__install__resource_header_dir}"
        COMPONENT "${ARG_HEADERS_COMPONENT}"
        INCLUDES DESTINATION "${cmut__install__include_dir}"
        )

    # install header directories

    set( header_scopes INTERFACE )
    if ( NOT target_type STREQUAL INTERFACE_LIBRARY )
        list( APPEND header_scopes PUBLIC )
    endif()
    foreach( scope IN LISTS header_scopes )
        cmut__target__get_header_directories( header_directories ${target} ${scope})
        if( header_directories )
            install(
                DIRECTORY   "${header_directories}"
                DESTINATION "${cmut__install__include_dir}"
                COMPONENT   ${ARG_HEADERS_COMPONENT}
            )
        endif()
    endforeach()

    # install generated headers
    if( target_type IN_LIST library_target_type )
        cmut__target__get_generated_header_output_directory( generated_header_output_directory ${target} )
        cmut__target__get_generated_forward_header_paths( generated_forward_header_paths ${target} )
        cmut__target__get_generated_export_header_path( generated_export_header_path ${target} )
        cmut__target__get_generated_version_header_path( generated_version_header_path ${target} )

        __cmut__install__install_header( ${target}
            ${ARG_HEADERS_COMPONENT}
            "${generated_header_output_directory}"
            "${generated_forward_header_paths}"
            "${generated_export_header_path}"
            "${generated_version_header_path}"
            )
    endif()


    if( target_type IN_LIST library_target_type )
        __cmut__install__export_target( ${target} )
    endif()

    cmut__install__component__add_dependencies( ${ARG_COMPONENT} ${target} )
    cmut__install__component__add_dependencies( ${ARG_HEADERS_COMPONENT} ${target} )

    cmut__project__add_components( ${target} )

endfunction()



function(__cmut__install__export_target target)

    cmut__export__target( ${target} )

    # install export file
    install(
        EXPORT "${target}"
        NAMESPACE "${cmut__install__export_namespace}"
        DESTINATION "${cmut__install__config_dir}/${target}"
        COMPONENT devel
    )

endfunction()



function(__cmut__install__install_header target install_component directory_base )

    foreach( filepath ${ARGN} )

        if( NOT EXISTS ${filepath} )
            continue()
        endif()

        get_filename_component( directory "${filepath}" DIRECTORY )
        if( directory_base )
            file( RELATIVE_PATH directory ${directory_base} ${directory} )
        endif()

        install(
            FILES       "${filepath}"
            DESTINATION "${cmut__install__include_dir}/${directory}"
            COMPONENT   ${install_component}
            )

    endforeach()

endfunction()
