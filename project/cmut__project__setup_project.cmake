

macro(cmut__project__setup_project)

    cmut__lang__arg__set_params(
        OPT
        "CXX_EXTENSIONS"
        "CXX_STANDARD"
        ""
        )

    cmut__lang__arg__add_params(
        OPT
        "WARNING_AGGRESSIVE;WARNING_AS_ERROR"
        ""
        "WARNING_NO_ERROR"
        )

    cmut__lang__arg__add_params(
        OPT
        ""
        "DEBUG_POSTFIX"
        ""
        )

    cmut__lang__arg__add_params(
        OPT
        ""
        "CXX_VISIBILITY"
        ""
        )

    cmut__lang__arg__add_params(
        OPT
        ""
        "OUTPUT_BASE_DIR"
        ""
        )



    cmut__lang__arg__parse_defined_options(
        cmut__project__setup_project
        ARG
        OPT
        ${ARGN}
    )

    cmut__lang__arg__set_default( DEBUG_POSTFIX "d" )
    set(CMAKE_DEBUG_POSTFIX ${ARG_DEBUG_POSTFIX})


    # define CMAKE_*_OUTPUT_DIRECTORY
    cmut__lang__arg__set_if_option( OUTPUT_BASE_DIR OPTIONS "${ARG_OUTPUT_BASE_DIR}")
    cmut__build__define_output_dir( ${OPTIONS} )


    cmut__build__enable_color_with_ninja()


    # enable C++14
    cmut__lang__arg__set_default( CXX_STANDARD "14" )
    cmut__lang__arg__set_if_option( CXX_EXTENSIONS OPTIONS CXX_EXTENSIONS )
    cmut__build__enable_cxx_standard(${ARG_CXX_STANDARD} ${OPTIONS} )

    # enable warning
    cmut__lang__arg__set_if_option( WARNING_AGGRESSIVE OPTIONS AGGRESSIVE )
    cmut__lang__arg__add_if_option( WARNING_AS_ERROR OPTIONS ERROR )
    cmut__lang__arg__add_if_option( WARNING_NO_ERROR OPTIONS NO_ERROR ${ARG_WARNING_NO_ERROR} )
    cmut__build__enable_warning( ${OPTIONS} )

    # use RUNPATH instead of depreciated RPATH
    cmut__build__enable_runpath_link()

    cmut__lang__arg__set_default( CXX_VISIBILITY hidden )
    cmut__build__set_cxx_visibility( ${ARG_CXX_VISIBILITY} )

    # add option to enable build with all cpu's core when use Visual Studio or nmake
    cmut__build__msvc__option_use_mp()

endmacro()
