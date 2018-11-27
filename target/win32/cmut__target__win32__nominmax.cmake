


function(cmut__target__win32__nominmax target)

    if(NOT WIN32)
        return()
    endif()

    cmut__target__details__public_compile_definitions( ${target} NOMINMAX )

endfunction()
