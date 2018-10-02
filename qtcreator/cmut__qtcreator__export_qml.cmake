# In order to use qtcreator inspector to load modules QML dynamically
# and propose code completion in multi libraries environment we have to export
# QML files and set QML_IMPORT_PATH variable.

function(cmut__qtcreator__export_qml target qml_directories)

    if(NOT ARGC)
        return()
    endif()

    install( DIRECTORY ${qml_directories}
             DESTINATION qml
             COMPONENT runtime
             FILES_MATCHING
             PATTERN "*.qml"
             PATTERN "qmldir" )


     set_target_properties(${target} PROPERTIES QML_IMPORT_PATH qml)

     get_target_property(_export_properties ${target} EXPORT_PROPERTIES)
     list(APPEND _export_properties QML_IMPORT_PATH)

     set_target_properties(${target} PROPERTIES EXPORT_PROPERTIES "${_export_properties}")

endfunction()
