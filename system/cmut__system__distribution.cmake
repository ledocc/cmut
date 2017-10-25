




function(cmut__system__lsb_release result)

    if(NOT CMAKE_SYSTEM_NAME STREQUAL "Linux")
        cmut_error("cmut__system__lsb_release is only available on linux platform")
    endif()


    if(NOT LSB_RELEASE_COMMAND)
        find_file(LSB_RELEASE_COMMAND lsb_release)

        if(NOT LSB_RELEASE_COMMAND)
            cmut_fatal("Can't find lsb_release, check if it is installed.")
        endif()
    endif()


    cmut__utils__parse_arguments(
        cmut__system__lsb_release
        CMUT__SYSTEM__LSB_RELEASE__ARG
        "ID;RELEASE;CODENAME"
        ""
        ""
        ${ARGN}
        )


    if(CMUT__SYSTEM__LSB_RELEASE__ARG_ID)
        set(lsb_release_opt -i)
    elseif(DEFINED CMUT__SYSTEM__LSB_RELEASE__ARG_RELEASE)
        set(lsb_release_opt -r)
    elseif(DEFINED CMUT__SYSTEM__LSB_RELEASE__ARG_CODENAME)
        set(lsb_release_opt -c)
    else()
        cmut_warn("cmut__system__lsb_release call with no valid argument.")
    endif()
    endif()

    execute_process(COMMAND ${LSB_RELEASE_COMMAND} -s ${lsb_release_opt}
        OUTPUT_VARIABLE lsb_release_result
        OUTPUT_STRIP_TRAILING_WHITESPACE
        )

    set(${result} "${lsb_release_result}" PARENT_SCOPE)

endfunction()


function(cmut__system__get_distribution_name result)

    cmut__system__lsb_release(_result ID)
    set(${result} ${_result} PARENT_SCOPE)

endfunction()

function(cmut__system__get_distribution_version result)

    cmut__system__lsb_release(_result RELEASE)
    set(${result} ${_result} PARENT_SCOPE)

endfunction()
