


include("${CMAKE_CURRENT_LIST_DIR}/../cmut__utils.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmut__install__install_or_update.cmake")

set(cmut__install__install_dependencies__this_file "${CMAKE_CURRENT_LIST_FILE}")

########################################################################################################################
########################################################################################################################
########################################################################################################################

function(__cmut__install__install_dependencies__make_executable outputPath)

    get_filename_component(outputDir ${outputPath} DIRECTORY)
    get_filename_component(target ${outputPath} NAME_WE)

    cmut__utils__mkdir("${outputDir}/src")

    set(sourcePath "${outputDir}/src/${target}.cpp")
    file(WRITE "${sourcePath}" "int main(int, char**) { return 0; }")

    add_executable(
        ${target}
        "${sourcePath}"
    )
    set_target_properties(
        ${target}
        PROPERTIES
            LINK_WHAT_YOU_USE 0
            RUNTIME_OUTPUT_DIRECTORY ${outputDir}
    )

    target_link_libraries(
        ${target}
        ${ARGN}
    )

endfunction()

function(__cmut__install__install_dependencies__apply binary_ recursive_ excludeSystem_ destination_ )

    cmut__utils__parse_arguments(
        __cmut__install__install_dependencies__apply
        ARG
        ""
        ""
        "LIBRARY_DIR"
        ${ARGN}
        )

    cmut__utils__error_if_empty(binary_)
    cmut__utils__error_if_empty(destination_)

    include(GetPrerequisites)
    get_prerequisites(
        "${binary_}"
        myPrerequisites
        ${recursive_}
        ${excludeSystem_}
        ""
        "${ARG_LIBRARY_DIR}"
        )

    foreach(dep IN LISTS myPrerequisites)
        cmut__install__install_or_update("${dep}" "${destination_}")
    endforeach()

endfunction()




########################################################################################################################
########################################################################################################################
########################################################################################################################



function(cmut__install__install_dependencies name)

    cmut__utils__parse_arguments(
        cmut__install__install_dependencies
        ARG
        "RECURSIVE;EXCLUDE_SYSTEM"
        "BINARY;DESTINATION;COMPONENT"
        "LIBRARY_DIR;TARGET"
        ${ARGN}
        )

    cmut__utils__set_if_defined(recursive ARG_RECURSIVE 1 0)
    cmut__utils__set_if_defined(excludeSystem ARG_EXCLUDE_SYSTEM 1 0)
    cmut__utils__set_if_defined(component ARG_COMPONENT "${ARG_COMPONENT}" "Unspecified")

    cmut__utils__error_if_all_empty(ARG_BINARY ARG_TARGET)
    cmut__utils__error_if_empty(ARG_DESTINATION)


    if(DEFINED ARG_TARGET)
        set(outputDirectory "${PROJECT_BINARY_DIR}/cmut/install/install_dependencies")
        set(target cmut__install__${name}dependenciesCollector)
        set(outputFilename "${target}${CMAKE_EXECUTABLE_SUFFIX}")
        set(ARG_BINARY "${outputDirectory}/${outputFilename}")

        # create executable that link with all dependencies
        __cmut__install__install_dependencies__make_executable(${ARG_BINARY} ${ARG_TARGET})


        if(DEFINED ARG_COMPONENT)
            # add this executable to component's dependencies
            cmut__install__add_component_dependencies(${ARG_COMPONENT} ${target})
        endif()

    endif()


    install(CODE "
        include(\"${cmut__install__install_dependencies__this_file}\")
        __cmut__install__install_dependencies__apply(
            \"${ARG_BINARY}\"
            ${recursive}
            ${excludeSystem}
            \"\${CMAKE_INSTALL_PREFIX}/${ARG_DESTINATION}\"
            LIBRARY_DIR \"${ARG_LIBRARY_DIR}\"
        )
        "
        COMPONENT ${component}
    )

endfunction()






function(cmut__install__install_directory_items directory_)

    cmut__utils__parse_arguments(
        cmut__install__install_directory_items
        ARG
        "EXCLUDE_FROM_ALL"
        "COMPONENT"
        ""
        ${ARGN}
        )



    file(
        GLOB items
        RELATIVE "${directory_}"
        "${directory_}/*"
    )


    list(LENGTH items itemsLenght)
    if(NOT ${itemsLenght})
        cmut_warn("${directory_} directory is empty. Nothing to install.")
        return()
    endif()


    __cmut__install__define_variables()

    if(DEFINED ARG_COMPONENT)
        set(__component_directive COMPONENT ${ARG_COMPONENT})
    endif()

    if(DEFINED ARG_EXCLUDE_FROM_ALL)
        set(__exclude_from_all_directive EXCLUDE_FROM_ALL)
    endif()

    foreach(__dir IN LISTS items)

        if(NOT IS_DIRECTORY "${directory_}/${__dir}")
            continue()
        endif()

        install(
            DIRECTORY   "${directory_}/${__dir}"
            DESTINATION "."
            ${__exclude_from_all_directive}
            ${__component_directive}
        )

    endforeach()

endfunction()
