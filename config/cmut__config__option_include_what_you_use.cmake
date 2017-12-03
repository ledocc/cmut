

include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



# This option control the "include what you use" mode.
# When ON, all c/cxx compiled file is tested by iwyu, and useless include is reported at compile time
function(cmut__config__option_include_what_you_use defaultValue)

    if(NOT DEFINED IncludeWhatYouUse_FOUND)
        find_package(IncludeWhatYouUse)
    endif()

    if(NOT IncludeWhatYouUse_FOUND)
        return()
    endif()

    option(CMUT__CONFIG__IWYU "Set to ON to use iwyu (include_what_you_use)."  ${defaultValue})
    cmut_info("IWYU (include what you use) mode is ${CMUT__CONFIG__IWYU}")

    if(CMUT__CONFIG__IWYU)
        set(CMAKE_C_INCLUDE_WHAT_YOU_USE   "${IncludeWhatYouUse_COMMAND}" PARENT_SCOPE)
        set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE "${IncludeWhatYouUse_COMMAND}" PARENT_SCOPE)
    endif()

endfunction()
