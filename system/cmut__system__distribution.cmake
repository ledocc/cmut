




function(cmut__system__lsb_release result)

    if(NOT CMAKE_SYSTEM_NAME STREQUAL "Linux")
        cmut_error("cmut__system__lsb_release is only available on linux platform")
    endif()


    if(NOT DEFINED LSB_RELEASE_COMMAND)
        find_file(LSB_RELEASE_COMMAND lsb_release)

        if(NOT DEFINED LSB_RELEASE_COMMAND)
            cmut_error("Can't find lsb_release, check if it is installed.")
        endif()
    endif()


    cmut__utils__parse_function_arguments(
        cmut__system__lsb_release result
        "CMUT__SYSTEM__LSB_RELEASE__ARG"
        "ID RELEASE CODENAME"
        ""
        ""
        ${ARGC}
        )


    if(DEFINED CMUT__SYSTEM__LSB_RELEASE__ARG_ID)
        set(lsb_release_opt -i)
    elseif(DEFINED CMUT__SYSTEM__LSB_RELEASE__ARG_REVISION)
        set(lsb_release_opt -r)
    elseif(DEFINED CMUT__SYSTEM__LSB_RELEASE__ARG_CODENAME)
        set(lsb_release_opt -c)
    endif()

    execute_process(COMMAND ${LSB_RELEASE_COMMAND} -s ${lsb_release_opt}
        OUTPUT_VARIABLE lsb_release_result
        OUTPUT_STRIP_TRAILING_WHITESPACE
        )

    set(${result} ${lsb_release_result} PARENT_SCOPE)

endfunction()


function(cmut__system__get_distribution_name result)

    cmut__system__lsb_release(_result ID)
    set(${result} ${_result} PARENT_SCOPE)

endfunction()

function(cmut__system__get_distribution_version result)

    cmut__system__lsb_release(_result REVISION)
    set(${result} ${_result} PARENT_SCOPE)

endfunction()
