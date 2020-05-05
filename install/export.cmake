
function(cmut__install__export target)

    cmut__lang__function__init_param( cmut__install__export )
    cmut__lang__function__add_param( COMPONENT      DEFAULT devel )
    cmut__lang__function__add_param( DESTINATION    DEFAULT ${cmut__install__config_dir} )
    cmut__lang__function__add_param( NAMESPACE      DEFAULT ${PROJECT_NAME} )
    cmut__lang__function__parse_arguments( ${ARGN} )



    cmut__export__target( ${target} )

    # install export file
    install(
        EXPORT "${target}"
        NAMESPACE "${ARG_NAMESPACE}"
        DESTINATION "${ARG_DESTINATION}/${target}"
        COMPONENT ${ARG_COMPONENT})

endfunction()
