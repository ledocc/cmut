
macro(cmut__utils__set_in_parent_scope variable)

    cmut_deprecated_function( cmut__utils__set_in_parent_scope cmut__lang__forward_in_parent_scope  )
    cmut__lang__forward_parent_scope( ${variable} )

endmacro()

macro(cmut__utils__set_in_parent_scope_if_defined variable)

    cmut_deprecated_function( cmut__utils__set_in_parent_scope_if_defined cmut__lang__forward_in_parent_scope_if_defined )
    cmut__lang__forward_in_parent_scope_if_defined( ${variable} )

endmacro()
