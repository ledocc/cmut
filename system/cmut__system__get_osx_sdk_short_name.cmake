

function(cmut__system__get_osx_sdk_short_name result)
    
    if(NOT "${CMAKE_OSX_SYSROOT}" STREQUAL "")

        get_filename_component(name "${CMAKE_OSX_SYSROOT}" NAME)
        string(TOLOWER "${name}" name)
        string(REGEX MATCH "[a-z]+[0-9]+\.[0-9]+" name "${name}")

        set(${result} "${name}" PARENT_SCOPE)

    elseif(NOT "$ENV{SDKROOT}" STREQUAL "")

        set(${result} "$ENV{SDKROOT}" PARENT_SCOPE)
        
    else()

        cmut_warn("[cmut] - cmut__system__get_osx_sdk_short_name : neither cmake variable \"CMAKE_OSX_SYSROOT\" and environment variable \"SDKROOT\" empty.")
        set(${result} "" PARENT_SCOPE)

    endif()

endfunction()
