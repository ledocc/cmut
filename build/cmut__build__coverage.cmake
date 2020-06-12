
function(cmut__build__add_coverage_target)

    if(NOT CMAKE_BUILD_TYPE STREQUAL "Coverage")
        return()
    endif()

    set(target coverage)
    if(TARGET ${target})
        return()
    endif()

    cmut__coverage__setup_target(
        ${target} ctest
        HTML_DETAIL_OUTPUT coverage/index.html
        SORT_BY PERCENTAGE
        EXCLUDE_REGEX "${PROJECT_SOURCE_DIR}/test/"
        )

endfunction()
