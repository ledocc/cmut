# cmut__install__install_qml( target [DIRECTORY qml] [DESTINATION qml] [COMPONENT runtime] )
# - install qml
# - export qml files location in QML_LOCATION
function(cmut__install__install_qml target)

    cmut__utils__parse_arguments(
        cmut__install__install_qml
        ARG_
        ""
        "DESTINATION;COMPONENT"
        "DIRECTORY"
        ${ARGN}
    )

    if(NOT ARG__DIRECTORY)
        set(ARG__DIRECTORY "qml/${target}")
    endif()

    if(NOT ARG__DESTINATION)
        set(ARG__DESTINATION "qml")
    endif()

    if(NOT ARG__COMPONENT)
        set(ARG__COMPONENT runtime)
    endif()


    install( DIRECTORY ${ARG__DIRECTORY}
             DESTINATION ${ARG__DESTINATION}
             COMPONENT ${ARG__COMPONENT}
             FILES_MATCHING
             PATTERN "*.qml"
             PATTERN "qmldir" )

     set_target_properties(${target} PROPERTIES QML_LOCATION ${ARG__DESTINATION})

     get_target_property(_export_properties ${target} EXPORT_PROPERTIES)
     list(APPEND _export_properties QML_LOCATION)

     set_target_properties(${target} PROPERTIES EXPORT_PROPERTIES "${_export_properties}")

endfunction()
