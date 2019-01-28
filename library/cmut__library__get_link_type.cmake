




function(cmut__library__get_link_type result library_path)

    if(NOT EXISTS "${library_path}")
        cmut_fatal("[cmut][library][get_link_type] - \"${library_path}\" : no such file.")
    endif()

    if(WIN32)
        __cmut__library__get_link_type__win32( local_result "${library_path}" )
    elseif(APPLE)
        __cmut__library__get_link_type__apple( local_result "${library_path}" )
    else()
        __cmut__library__get_link_type__unix( local_result "${library_path}" )
    endif()

    cmut__lang__return(local_result)

endfunction()

function( __cmut__library__get_link_type__unix result library_path )

    find_program( OBJDUMP_COMMAND objdump )
    if(NOT OBJDUMP_COMMAND)
        cmut_fatal("[cmut][library][get_link_type] - \"objdump\" command not found! cmut can not determine library link type.")
    endif()

    find_program( AR_COMMAND ar )
    if(NOT AR_COMMAND)
        cmut_fatal("[cmut][library][get_link_type] - \"ar\" command not found! cmut can not determine library link type.")
    endif()

    execute_process(
        COMMAND ${OBJDUMP_COMMAND} -T "${library_path}"
        RESULT_VARIABLE objdump_result
        OUTPUT_QUIET
        ERROR_QUIET
        )

    execute_process(
        COMMAND ${AR_COMMAND} p "${library_path}"
        RESULT_VARIABLE ar_result
        OUTPUT_QUIET
        ERROR_QUIET
        )


    if(objdump_result AND ar_result)
        cmut_fatal("[cmut][library][get_link_type] - \"${library_path}\" is either a static or dynamic library.")
    endif()

    if(objdump_result AND NOT ar_result)
        cmut__lang__return_value(STATIC_LIBRARY)
    endif()

    if(NOT objdump_result AND ar_result)
        cmut__lang__return_value(DYNAMIC)
    endif()

    if(NOT objdump_result AND NOT ar_result)
        cmut_fatal("[cmut][library][get_link_type] - \"${library_path}\" is a static and a dynamic library.")
    endif()


endfunction()


function( __cmut__library__get_link_type__apple result library_path )

    find_program( OBJDUMP_COMMAND objdump )
    if(NOT OBJDUMP_COMMAND)
        cmut_fatal("[cmut][library][get_link_type] - \"objdump\" command not found! cmut can not determine library link type.")
    endif()

    execute_process(
        COMMAND "${CMUT_ROOT}/library/macos/get_link_type.sh" "${OBJDUMP_COMMAND}" "${library_path}"
        RESULT_VARIABLE objdump_result
        OUTPUT_VARIABLE objdump_output
        ERROR_VARIABLE objdump_error
	OUTPUT_STRIP_TRAILING_WHITESPACE
        )

    if(objdump_result)
        cmut_fatal("[cmut][library][get_link_type] - error while determine \"${library_path}\" link type : ${objdump_error}.")
    endif()


    if("${objdump_output}" STREQUAL OBJECT)
        cmut__lang__return_value(STATIC_LIBRARY)
    elseif("${objdump_output}" STREQUAL DYLIB)
        cmut__lang__return_value(DYNAMIC_LIBRARY)
    else()
        cmut_fatal("[cmut][library][get_link_type] - \"${library_path}\" : library type not handle : ${objdump_output}.")
    endif()


endfunction()
