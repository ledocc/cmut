

function( cmut__install__install_cmut__dependency_files )

    cmut__install__install_config_file(
        ${ARGN}
        FILES
            "${CMUT_ROOT}/dependency/cmut__dependency__add.cmake"
            "${CMUT_ROOT}/dependency/cmut__dependency__find.cmake"
    )

endfunction()
