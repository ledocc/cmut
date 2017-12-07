


function(cmut__build__set_cxx_visibility value)

    if(${value} STREQUAL "")
        cmut_error("cmut__build__set_cxx_visibility : invalid arguments")
        return()
    endif()


    if(${value} STREQUAL "default")

        set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON PARENT_SCOPE)
        set(CMAKE_CXX_VISIBILITY_PRESET default PARENT_SCOPE)
        set(CMAKE_VISIBILITY_INLINES_HIDDEN OFF PARENT_SCOPE)

    elseif(${value} STREQUAL "inlines_hidden")

        set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON PARENT_SCOPE)
        set(CMAKE_CXX_VISIBILITY_PRESET default PARENT_SCOPE)
        set(CMAKE_VISIBILITY_INLINES_HIDDEN ON PARENT_SCOPE)

    elseif(${value} STREQUAL "hidden")

        set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS OFF PARENT_SCOPE)
        set(CMAKE_CXX_VISIBILITY_PRESET hidden PARENT_SCOPE)
        set(CMAKE_VISIBILITY_INLINES_HIDDEN ON PARENT_SCOPE)

    else()

        cmut_error("cmut__build__set_cxx_visibility : visibility \"${value}\" not handle")
        return()

    endif()


    cmut_info("[cmut] - cxx use \"${value}\" visibility")

endfunction()
