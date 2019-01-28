


macro(cmut__lang__return variable)
    set(${result} "${${variable}}" PARENT_SCOPE)
endmacro()

macro(cmut__lang__return_value value)
    set(${result} "${value}" PARENT_SCOPE)
endmacro()
