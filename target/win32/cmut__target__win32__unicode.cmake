


function(cmut__target__win32__unicode target)

    if(NOT WIN32)
        return()
    endif()

    cmut__target__details__public_compile_definitions( ${target} UNICODE )

endfunction()
