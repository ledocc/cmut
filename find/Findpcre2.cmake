


find_path(pcre2_INCLUDE_DIRS pcre2.h)
find_library(pcre2-8_LIBRARY pcre2-8)
find_library(pcre2-16_LIBRARY pcre2-16)
find_library(pcre2-32_LIBRARY pcre2-32)
find_library(pcre2-posix_LIBRARY pcre2-posix)
set(pcre2_LIBRARIES ${pcre2-8_LIBRARY} ${pcre2-16_LIBRARY} ${pcre2-32_LIBRARY} ${pcre2-posix_LIBRARY})



include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(
    pcre2 FOUND_VAR pcre2_FOUND
    REQUIRED_VARS
        pcre2_INCLUDE_DIRS
        pcre2_LIBRARIES
    )




function( pcre2__add_library libname )

    if( TARGET pcre2::${libname})
        return()
    endif()

    add_library( pcre2::${libname} UNKNOWN IMPORTED )

    set_target_properties(
        pcre2::${libname}
        PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${pcre2_INCLUDE_DIRS}"
    )

    set_target_properties(
        pcre2::${libname}
        PROPERTIES
            IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
            IMPORTED_LOCATION "${${libname}_LIBRARY}"

            IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
            IMPORTED_LOCATION_RELEASE "${${libname}_LIBRARY}"
    )

endfunction()

if( pcre2_FOUND )

    pcre2__add_library(pcre2-8)
    pcre2__add_library(pcre2-16)
    pcre2__add_library(pcre2-32)
    pcre2__add_library(pcre2-posix)

endif()
