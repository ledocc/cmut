


function(cmut__target__win32__secure_no_warning target)

    if(NOT WIN32)
        return()
    endif()

    cmut__target__details__public_compile_definitions( ${target}
        _SCL_SECURE_NO_WARNINGS
        _CRT_SECURE_NO_WARNINGS
        )

endfunction()
