# Finds the libproxy Library
#
#  libproxy_FOUND        - True if libproxy library found.
#
#  LIBPROXY_INCLUDE_DIRS - Directory to include to get libproxy headers
#
#  LIBPROXY_LIBRARIES    - Libraries to link against for libproxy
#
#
#  libproxy::libproxy    - exported libproxy library target


include(FindPackageHandleStandardArgs)



# Look for the header file.
find_path(
    LIBPROXY_INCLUDE_DIR
    NAMES proxy.h
    DOC "Include directory for the libproxy library"
)
mark_as_advanced(LIBPROXY_INCLUDE_DIR)
set(LIBPROXY_INCLUDE_DIRS ${LIBPROXY_INCLUDE_DIR})



# Look for the library.
find_library(
    LIBPROXY_LIBRARY
    NAMES proxy libproxy
    DOC "Libraries to link against for libproxy"
)
mark_as_advanced(LIBPROXY_LIBRARY)
set(LIBPROXY_LIBRARIES ${LIBPROXY_LIBRARY})

find_package_handle_standard_args(
    libproxy
    REQUIRED_VARS
        LIBPROXY_INCLUDE_DIRS
        LIBPROXY_LIBRARIES
)

if(libproxy_FOUND)

    if(NOT TARGET libproxy::libproxy)
        add_library(libproxy::libproxy UNKNOWN IMPORTED)
        set_target_properties(
            libproxy::libproxy
            PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${LIBPROXY_INCLUDE_DIRS}"
        )

        set_target_properties(
            libproxy::libproxy
            PROPERTIES
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
                IMPORTED_LOCATION "${LIBPROXY_LIBRARY}"

                IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
                IMPORTED_LOCATION_RELEASE "${LIBPROXY_LIBRARY}"
        )
    endif()

endif()
