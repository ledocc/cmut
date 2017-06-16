
function(cmut__find__import_target namespace target)

    cmut__utils__parse_arguments(cmut__find__import_target
        __ARG
        "DEFAULT"
        "INCLUDE_DIR;LANGUAGE;LIBRARY;CONFIG"
        "LINK_LIBRARIES"
        )

    if (DEFINED __ARG_CONFIG)
        set(CONFIG_SUFFIX _${CONFIG})
    endif()


    if (NOT TARGET ${namespace}::${target})
        add_library(${namespace}::${target} UNKNOWN IMPORTED)
    endif()

    if (DEFINED __ARG_INCLUDE_DIR)
        set_target_properties(
            ${namespace}::${target}
            PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${ARG_INCLUDE_DIR}"
            )
    endif()

    if (DEFINED __ARG_LANGUAGE)
        set_target_properties(
            ${namespace}::${target}
            PROPERTIES
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
            )
    endif()

    if (DEFINED __ARG_LIBRARY)
        set_target_properties(
            ${namespace}::${target}
            PROPERTIES
                IMPORTED_LOCATION${CONFIG_SUFFIX} "${__ARG_LIBRARY}"
            )

        if (__ARG_DEFAULT)
            set_target_properties(
                ${namespace}::${target}
                PROPERTIES
                    IMPORTED_LOCATION "${__ARG_LIBRARY}"
                )
        endif()
    endif()

    if (DEFINED __ARG_LINK_LIBRARIES)
        set_target_properties(
            ${namespace}::${target}
            PROPERTIES
                INTERFACE_LINK_LIBRARIES${CONFIG_SUFFIX} ${__ARG_LINK_LIBRARIES}
            )

        if (__ARG_DEFAULT)
            set_target_properties(
                ${namespace}::${target}
                PROPERTIES
                    INTERFACE_LINK_LIBRARIES ${__ARG_LINK_LIBRARIES}
                )
        endif()
    endif()

endfunction()
