


macro(cmut__lang__return variable)
    cmut__lang__set_in_parent_scope( ${result} "${${variable}}" )
endmacro()

macro(cmut__lang__return_value )
    cmut__lang__set_in_parent_scope( ${result} "${ARGN}" )
endmacro()
