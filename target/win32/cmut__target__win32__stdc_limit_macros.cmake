

function(cmut__target__win32__stdc_limit_macros target)

    if(NOT WIN32)
        return()
    endif()

    cmut__target__details__public_compile_definitions( ${target} __STDC_LIMIT_MACROS )

endfunction()
