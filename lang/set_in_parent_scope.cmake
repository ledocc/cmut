
macro( cmut__lang__set_in_parent_scope var )

    set( ${var} "${ARGN}" PARENT_SCOPE )

endmacro()

macro( cmut__lang__unset_in_parent_scope var )

    unset( ${var} PARENT_SCOPE )

endmacro()

macro( cmut__lang__forward_in_parent_scope var )

    set( ${var} "${${var}}" PARENT_SCOPE )

endmacro()

macro(cmut__lang__forward_in_parent_scope_if_defined variable)

    if(DEFINED ${variable})
        cmut__lang__forward_in_parent_scope( ${variable} )
    endif()

endmacro()
