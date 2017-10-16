function(cmut__install__install_or_update source_ destination_)

    get_filename_component(file "${source_}" NAME)

    if(EXISTS "${destination_}")
        if(IS_DIRECTORY "${destination_}")
            set(installPath "${destination_}/${file}")
        else()
            set(installPath "${destination_}")
        endif()
    else()
        set(installPath "${destination_}")
    endif()


    if(EXISTS "${installPath}")
        set(action "Up-to-date")
    else()
        set(action "Installing")
    endif()
    message(STATUS "${action}: ${installPath}")

    set(command "${CMAKE_COMMAND}" -E copy "${source_}" "${installPath}")
    execute_process(COMMAND ${command}
        RESULT_VARIABLE result
        OUTPUT_VARIABLE output
        ERROR_VARIABLE  error
        )

    if(result)
        message(STATUS "error on command:")
        foreach(item IN LISTS command)
            message("    ${item}")
        endforeach()

        message(STATUS "result : ${result}")
        message(STATUS "output : ${output}")
        message(STATUS "error  : ${error}")
        message(FATAL_ERROR "aborting after copy error.")
    endif()


endfunction()
