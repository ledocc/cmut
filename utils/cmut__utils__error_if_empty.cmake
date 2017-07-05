

function(cmut__utils__error_if_empty var)

    if("${${var}}" STREQUAL "")
        cmut_error("variable ${var} is empty.")
    endif()

endfunction()


function(cmut__utils__error_if_all_empty)

    foreach (var IN LISTS ARGN)
        if(NOT "${var}" STREQUAL "")
            return()
        endif()
    endforeach()

    cmut_error("variable ${ARGN} are empty.")

endfunction()
