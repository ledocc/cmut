include("${CMAKE_CURRENT_LIST_DIR}/init.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/function_name_to_scope_name.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake")



macro( cmut__log__dev message )

    cmut__log__function_name_to_scope_name( "${CMAKE_CURRENT_FUNCTION}" "${origin}" )

    cmut_message(STATUS "dev" "${scope_name} : ${message}")

endmacro()

macro( cmut__log__var )

    foreach(var ${ARGN})
        cmut__log__dev("${var} = ${${var}}")
    endforeach()

endmacro()
