

function( cmut__target__define_cxx_standard target version )

    cmut__utils__parse_arguments(
        cmut__build__enable_cxx_standard
        ARG_
        "EXTENSIONS;REQUIRED"
        ""
        ""
        ${ARGN}
    )

    set_target_properties(
        ${target}
        PROPERTIES
            CXX_EXTENSIONS ${ARG_EXTENSIONS}
            CXX_STANDARD ${version}
            CXX_STANDARD_REQUIRED ${ARG_REQUIRED}
    )

endfunction()
