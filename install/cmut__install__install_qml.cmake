# cmut__install__install_qml( target DIRECTORY qml [DESTINATION qml] [COMPONENT runtime] )
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
        cmut_error("Argument DIRECTORY is mandatory")
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

     __cmut__append_qml_directories(${target} ${ARG__DESTINATION})
     __cmut__export_qml_directories(${target})

endfunction()


function (__cmut__append_qml_directories target qml_directories)

    get_target_property( _cmut__qml_directory ${target} CMUT__QML_DIRECTORIES)

    if(NOT _cmut__qml_directory)
        set(_cmut__qml_directory ${qml_directories})
    else()
        list(APPEND _cmut__qml_directory ${qml_directories})
    endif()

    set_target_properties(${target} PROPERTIES CMUT__QML_DIRECTORIES "${_cmut__qml_directory}")

endfunction()


function(__cmut__export_qml_directories target)

    get_target_property(_export_properties ${target} EXPORT_PROPERTIES)
    list(APPEND _export_properties CMUT__QML_DIRECTORIES)
    set_target_properties(${target} PROPERTIES EXPORT_PROPERTIES "${_export_properties}")

endfunction()
