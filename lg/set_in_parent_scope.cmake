

macro( lg_set_in_parent_scope var )

    set( ${var} "${ARGN}" PARENT_SCOPE )

endmacro()

macro( lg_unset_in_parent_scope var )

    unset( ${var} PARENT_SCOPE )

endmacro()

macro( lg_forward_in_parent_scope var )

    set( ${var} "${${var}}" PARENT_SCOPE )

endmacro()

macro(lg_forward_in_parent_scope_if_defined variable)

    if(DEFINED ${variable})
        cmut__lang__forward_in_parent_scope( ${variable} )
    endif()

endmacro()
