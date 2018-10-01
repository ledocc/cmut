# In order to use qtcreator inspector to load modules QML dynamically
# and propose code completion in client
# - install QML files
# - set and export a target property QML_IMPORT_PATH
function(cmut__qtcreator__export__qml target qml_directories)

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
