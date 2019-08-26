

function( cmut__export__target target )

    cmut__export__get_config_directory( destination ${target} )

    export(
            TARGETS ${target}
            NAMESPACE ${PROJECT_NAME}::
            FILE "${PROJECT_BINARY_DIR}/${destination}/${target}/${target}.cmake"
        )

endfunction()
