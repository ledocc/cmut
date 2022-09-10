
set(CMUT_DIR "${CMAKE_CURRENT_LIST_DIR}/..")
file(REAL_PATH ${CMUT_DIR} CMUT_DIR)


macro(utest__begin name)
    file( RELATIVE_PATH filepath "${CMUT_DIR}" "${CMAKE_CURRENT_LIST_FILE}" )
    message(STATUS "Start \"${name}\" tests from \"${filepath}\".")
    list(APPEND CMAKE_MESSAGE_INDENT "    ")
    set_property(GLOBAL PROPERTY utest_context ${name})
endmacro()

macro(utest__end)
    list(POP_BACK CMAKE_MESSAGE_INDENT)
    get_cmake_property(name utest_context)
    message(STATUS "\"${name}\" tests done.")
endmacro()


macro(utest__log_result test_result)

    set( test_name ${CMAKE_CURRENT_FUNCTION} )
    if(${test_result})
        message(STATUS "${test_name} : PASS")
    else()
        set(argn ${ARGN})
        list(JOIN argn " " tests_arg)
        message(WARNING "${test_name} : FAIL : \"${tests_arg}\"")
    endif()
    
endmacro()

macro(utest__if)

    set(test_result 0)
    if(${ARGN})
        set(test_result 1)
    endif()
    utest__log_result(${test_result} ${ARGN})
    
endmacro()
