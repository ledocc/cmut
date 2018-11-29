

macro(cmut__config__add_dependencies project package)

    cmut_deprecated( cmut__config__add_dependencies cmut__dependency__add )
    cmut__dependency__add( ${project} ${package} ${ARGN} )

endmacro()
