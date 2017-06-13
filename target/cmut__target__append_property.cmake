include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



function(cmut__target__append_property target property)

    if(ARGC LESS_EQUAL 2)
        return()
    endif()


    get_target_property(__value ${target} ${property})


    if(__value STREQUAL "__value-NOTFOUND")
        set(__value "")
    endif()
    list(APPEND __value ${ARGN})


    if(NOT __value STREQUAL "")
        message(STATUS "set_target_properties(${target} PROPERTIES ${property} ${__value})")
        set_target_properties(${target} PROPERTIES ${property} "${__value}")
    endif()

endfunction()
