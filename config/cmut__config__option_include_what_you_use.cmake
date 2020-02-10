

include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



# This option control the "include what you use" mode.
# When ON, all c/cxx compiled file is tested by iwyu, and useless include is reported at compile time
function(cmut__config__option_include_what_you_use defaultValue)

    cmut__lang__function__init_param(cmut__config__option_include_what_you_use)
    cmut__lang__function__add_option(QUOTED_INCLUDES_FIRST)
    cmut__lang__function__add_param(MAX_LINE_LENGHT DEFAULT 80)
    cmut__lang__function__add_multi_param(MAPPING_FILE)
    cmut__lang__function__parse_arguments(${ARGN})

    set(iwyu_ARGS)
    if(ARG_QUOTED_INCLUDES_FIRST)
        list( APPEND iwyu_ARGS -Xiwyu --quoted_includes_first )
    endif()
    list( APPEND iwyu_ARGS -Xiwyu --max_line_length=${ARG_MAX_LINE_LENGHT} )
    foreach(mapping_file IN LISTS ARG_MAPPING_FILE)
        list( APPEND iwyu_ARGS -Xiwyu --mapping_file=${mapping_file} )
    endforeach()


    if(NOT DEFINED IncludeWhatYouUse_FOUND)
        find_package(IncludeWhatYouUse)
    endif()

    if(NOT IncludeWhatYouUse_FOUND)
        return()
    endif()
    set(IncludeWhatYouUse_ARGS "${iwyu_ARGS}" CACHE STRING "L;st of arguments passed to includeWhatYouUse command.")


    option(CMUT__CONFIG__IWYU "Set to ON to use iwyu (include_what_you_use)."  ${defaultValue})
    cmut_info("[cmut][config] - IWYU (include what you use) mode is ${CMUT__CONFIG__IWYU}")

    if(CMUT__CONFIG__IWYU)
        set(CMAKE_C_INCLUDE_WHAT_YOU_USE   "${IncludeWhatYouUse_COMMAND};${IncludeWhatYouUse_ARGS}" PARENT_SCOPE)
        set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE "${IncludeWhatYouUse_COMMAND};${IncludeWhatYouUse_ARGS}" PARENT_SCOPE)
    endif()

endfunction()
