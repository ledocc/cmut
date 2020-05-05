
# cmut__install__target( target
#                        [COMPONENT component]
#                        [HEADERS_COMPONENT header_component] )
# 
# - install library and headers of target
# - generate and install <target name>Target.cmake
#
# component : name of target component
# header_component : name of target header component
# 
function(cmut__install__target target)

    # test the target
    if(NOT TARGET ${target})
        cmut__log__error( cmut__install__target "TARGET \"${target}\" not defined.")
        return()
    endif()

    __cmut__install__define_variables()

    cmut__lang__function__init_param( cmut__install__install_target )
    cmut__lang__function__add_param( COMPONENT                  DEFAULT runtime )
    cmut__lang__function__add_param( HEADERS_COMPONENT          DEFAULT devel )
    cmut__lang__function__add_param( ARCHIVE_DESTINATION        DEFAULT ${cmut__install__archive_dir} )
    cmut__lang__function__add_param( LIBRARY_DESTINATION        DEFAULT ${cmut__install__library_dir} )
    cmut__lang__function__add_param( RUNTIME_DESTINATION        DEFAULT ${cmut__install__runtime_dir} )
    cmut__lang__function__add_param( FRAMEWORK_DESTINATION      DEFAULT ${cmut__install__framework_dir} )
    cmut__lang__function__add_param( BUNDLE_DESTINATION         DEFAULT ${cmut__install__bundle_dir} )
    cmut__lang__function__add_param( PRIVATE_HEADER_DESTINATION DEFAULT ${cmut__install__private_header_dir} )
    cmut__lang__function__add_param( PUBLIC_HEADER_DESTINATION  DEFAULT ${cmut__install__public_header_dir} )
    cmut__lang__function__add_param( RESOURCE_DESTINATION       DEFAULT ${cmut__install__resource_header_dir} )
    cmut__lang__function__add_param( INCLUDES_DESTINATION       DEFAULT ${cmut__install__include_dir} )

    # deprecated parameters
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


    # install target
    install(
        TARGETS  ${target}
        EXPORT   ${target}
        ARCHIVE  DESTINATION "${ARG_ARCHIVE_DESTINATION}"
        COMPONENT "${ARG_COMPONENT}"
        LIBRARY  DESTINATION "${ARG_LIBRARY_DESTINATION}"
        COMPONENT "${ARG_COMPONENT}"
        RUNTIME  DESTINATION "${ARG_RUNTIME_DESTINATION}"
        COMPONENT "${ARG_COMPONENT}"
        FRAMEWORK DESTINATION "${ARG_FRAMEWORK_DESTINATION}"
        COMPONENT "${ARG_COMPONENT}"
        BUNDLE DESTINATION "${ARG_BUNDLE_DESTINATION}"
        COMPONENT "${ARG_COMPONENT}"
        PRIVATE_HEADER DESTINATION "${ARG_PRIVATE_HEADER_DESTINATION}"
        COMPONENT "${ARG_HEADERS_COMPONENT}"
        PUBLIC_HEADER  DESTINATION "${ARG_PUBLIC_HEADER_DESTINATION}"
        COMPONENT "${ARG_HEADERS_COMPONENT}"
        RESOURCE       DESTINATION "${ARG_RESOURCE_DESTINATION}"
        COMPONENT "${ARG_HEADERS_COMPONENT}"
        INCLUDES DESTINATION "${ARG_INCLUDES_DESTINATION}"
        )

    
    # install header directories
    if( target_type IN_LIST library_target_type )
        cmut__install__header_directories( ${target} )
        cmut__install__generated_headers( ${target} )
        cmut__install__export( ${target} )
    endif()

    cmut__install__component__add_dependencies( ${ARG_COMPONENT} ${target} )
    cmut__install__component__add_dependencies( ${ARG_HEADERS_COMPONENT} ${target} )

    cmut__project__add_components( ${target} )

endfunction()

