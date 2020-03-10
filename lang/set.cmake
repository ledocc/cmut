



function( cmut__lang__set_if_not_defined variable )

    cmut_deprecated_function(cmut__lang__set_if_not_defined cmut__lang__set_default)

    cmut__lang__set_default( ${variable} ${ARGN} )

endfunction()
