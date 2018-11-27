
function(cmut__config__win32__enable_unicode)

    if(NOT WIN32)
        return()
    endif()

    add_definitions(-DUNICODE)

endfunction()
