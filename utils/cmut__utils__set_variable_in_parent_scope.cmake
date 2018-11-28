
macro(cmut__utils__set_variable_in_parent_scope variable)

    set( ${variable} "${${variable}}" PARENT_SCOPE )

endmacro()

macro(cmut__utils__set_variable_in_parent_scope_if_defined variable)

    if(DEFINED ${variable})
        cmut__utils__set_variable_in_parent_scope( ${variable} )
    endif()

endmacro()
