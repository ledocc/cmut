


function(cmut__target__win32__win32_lean_and_mean target)

    if(NOT WIN32)
        return()
    endif()

    cmut__target__details__public_compile_definitions( ${target} WIN32_LEAN_AND_MEAN )

endfunction()
