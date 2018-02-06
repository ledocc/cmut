

## return a system/architecture target id for an executable
# ex : windows  : win32 or win64
#      linux    : Debian-9.2-x86_64 or Ubuntu-16.0-x86' or ...
#      apple    : Darwin
#      android  : Android
function(cmut__build__get_executable_build_id result)

    set(system_name ${CMAKE_SYSTEM_NAME})
    if(CMAKE_SYSTEM_NAME MATCHES "Windows")

        if(CMAKE_SIZEOF_VOID_P EQUAL 8)
            set(system_name win64)
        else()
            set(system_name win32)
        endif()

    elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")

        cmut__system__get_distribution_name(distribution_name)
        cmut__system__get_distribution_version(distribution_version)

        if(CMAKE_SIZEOF_VOID_P EQUAL 8)
            set(abi x86_64)
        else()
            set(abi x86)
        endif()

        set(system_name "${distribution_name}-${distribution_version}-${abi}")

    elseif(CMAKE_SYSTEM_NAME MATCHES "Android")
        set(system_name "Android-api-${CMAKE_SYSTEM_VERSION}-${CMAKE_ANDROID_ARCH_ABI}")
    elseif(CMAKE_SYSTEM_NAME MATCHES "Darwin")
        set(system_name "Darwin")
    endif()

    set(${result} ${system_name} PARENT_SCOPE)

endfunction()


## return a system/architecture target id for a library
# schema :
#      windows  : <compiler_id>-<arch>
#      linux    : <distribution_id>-<arch>
#      apple    : Darwin-<sdk>
#      android  : Android-<api_level>-<abi>
function(cmut__build__get_library_build_id result)

    set(system_name ${CMAKE_SYSTEM_NAME})
    if(CMAKE_SYSTEM_NAME MATCHES "Windows")

        if(MSVC)
            set(system_name msvc${MSVC_VERSION})
        else()
            cmut_error("cmut__build__get_library_build_id not implemented for ${CMAKE_<LANG>_COMPILER_ID} on Windows.")
        endif()

    elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")

        cmut__system__get_distribution_name(distribution_name)
        cmut__system__get_distribution_version(distribution_version)

        if(CMAKE_SIZEOF_VOID_P EQUAL 8)
            set(abi x86_64)
        else()
            set(abi x86)
        endif()

        set(system_name "${distribution_name}-${distribution_version}-${abi}")

    elseif(CMAKE_SYSTEM_NAME MATCHES "Android")
        set(system_name "Android-api-${CMAKE_SYSTEM_VERSION}-${CMAKE_ANDROID_ARCH_ABI}")
    elseif(CMAKE_SYSTEM_NAME MATCHES "Darwin")
        cmut__system__get_osx_sdk_short_name(sdk)

        set(system_name "Darwin-${sdk}")
    endif()

    set(${result} ${system_name} PARENT_SCOPE)

endfunction()
