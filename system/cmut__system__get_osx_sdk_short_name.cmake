

function(cmut__system__get_osx_sdk_short_name result)

    get_filename_component(name ${CMAKE_OSX_SYSROOT} NAME)
    string(TOLOWER ${name} name)
    string(REGEX MATCH "[a-z]+[0-9]+\.[0-9]+" name ${name})

    set(${result} "${name}" PARENT_SCOPE)

endfunction()
