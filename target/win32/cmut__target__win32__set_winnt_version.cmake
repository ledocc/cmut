

# this function allow user to define which winnt version to use
function(cmut__target__win32__set_winnt_version target version)

    if(NOT WIN32)
        return()
    endif()

    if(${version} STREQUAL "")
        set(version "0x601")
    endif()

    cmut__target__details__public_compile_definitions( ${target} _WIN32_WINNT=${version} )

endfunction()
