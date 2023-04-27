# In order to use qtcreator inspector to load modules QML dynamically
# and propose code completion in multi libraries environment we have to export
# QML files and set QML_IMPORT_PATH variable.

# cmut__qtcreator__import_qml(target [DIRECTORY qml])
# - import target qml if DIRECTORY is specified
# - import dependencies qml defin in dependency property CMUT__QML_DIRECTORIES
function(cmut__qtcreator__import_qml target)

    cmut__utils__parse_arguments(
        cmut__install__install_qml
        ARG_
        ""
        ""
        "DIRECTORY"
        ${ARGN}
    )

    if(NOT ARG__DIRECTORY)
        set(ARG__DIRECTORY "")
    else()
        cmut_info("[cmut][qtcreator][import_qml] - add ${ARG__DIRECTORY} in qml import path")
    endif()


    __cmut__qtcreator__get_dependencies_qml_directories(${target} _dependencies_qml_directories)
    if(_dependencies_qml_directories)
        cmut_info("[cmut][qtcreator][import_qml] - add ${_dependencies_qml_directories} in qml import path")
    endif()


    get_property( _qml_import_path CACHE QML_IMPORT_PATH PROPERTY VALUE)
    list(APPEND _qml_import_path ${ARG__DIRECTORY} ${_dependencies_qml_directories})

    if(NOT _qml_import_path)
        return()
    endif()

    list(REMOVE_DUPLICATES _qml_import_path)
    set( QML_IMPORT_PATH ${_qml_import_path}
         CACHE INTERNAL "Qml import path" FORCE
    )

endfunction()


function(__cmut__qtcreator__get_dependencies_qml_directories target qml_directories)

    get_target_property(_target_dependencies ${target} LINK_LIBRARIES)
    __cmut__qtcreator__get_qml_import_paths(_qml_directories "${_target_dependencies}")

    set(${qml_directories} ${_qml_directories} PARENT_SCOPE)

endfunction()


function(__cmut__qtcreator__get_dependency_install_directory dependency_install_directory dependency)
# PREDICATE Library directory is one delph children of install directory

    string(TOUPPER ${CMAKE_BUILD_TYPE} BUILD_TYPE_UPPER)
    get_target_property(_dependency_location ${dependency} IMPORTED_LOCATION_${BUILD_TYPE_UPPER})
    if(NOT _dependency_location)
        get_target_property(_dependency_location ${dependency} IMPORTED_LOCATION)
    endif()

    if( NOT _dependency_location )
        cmut_error("[cmut][qtcreator][import_qml] - We can't find your dependency location.
                    Verify your build type (Release, Debug, Asan, Coverage)")
    endif()

    get_filename_component(_dependency_directory ${_dependency_location} DIRECTORY)
    get_filename_component(_dependency_directory ${_dependency_directory} DIRECTORY)
    set(${dependency_install_directory} ${_dependency_directory} PARENT_SCOPE)

endfunction()


function(__cmut__qtcreator__get_qml_import_paths target_qml_import_paths target_dependencies)

    set(_qml_import_paths)
    foreach(_dependency IN LISTS target_dependencies)
        get_target_property(_qml_directories ${_dependency} CMUT__QML_DIRECTORIES)

        if( NOT _qml_directories)
            continue()
        endif()

        foreach( _qml_directory IN LISTS _qml_directories)
            __cmut__qtcreator__get_dependency_install_directory(_dependency_install_dir ${_dependency})
            if(EXISTS ${_dependency_install_dir})
                list(APPEND _qml_import_paths "${_dependency_install_dir}/${_qml_directory}")
            endif()
        endforeach()

    endforeach()

    if( NOT _qml_import_paths)
        return()
    endif()

    list(REMOVE_DUPLICATES _qml_import_paths)

    set(${target_qml_import_paths} ${_qml_import_paths} PARENT_SCOPE)

endfunction()
