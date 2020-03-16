include_guard(GLOBAL)

include("${CMAKE_CURRENT_LIST_DIR}/set_in_parent_scope.cmake")

macro(cmut__lang__return variable)
    cmut__lang__set_in_parent_scope( ${result} "${${variable}}" )
endmacro()

macro(cmut__lang__return_value )
    cmut__lang__set_in_parent_scope( ${result} "${ARGN}" )
endmacro()

macro(cmut__lang__return_unset variable)
    cmut__lang__unset_in_parent_scope( ${result}  )
endmacro()
