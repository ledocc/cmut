# Locate libvncserver
# This module defines
#
# LibVNCServer_Client_INCLUDE_DIRS
# LibVNCServer_Client_LIBRARIES
# LibVNCServer_Client_FOUND
#
# LibVNCServer_Server_INCLUDE_DIRS
# LibVNCServer_Server_LIBRARIES
# LibVNCServer_Server_FOUND
#
# $LibVNCServer_DIR is an environment variable that would
# correspond to the ./configure --prefix=$LibVNCServer_DIR
# used in building libvncserver.


set(_LibVNCServer_path_to_search ENV LibVNCServer_DIR)

find_path(LibVNCServer_INCLUDE_DIR rfb/rfb.h
    HINTS ${_LibVNCServer_path_to_search}
    PATH_SUFFIXES include
)
set(LibVNCServer_Client_INCLUDE_DIRS ${LibVNCServer_INCLUDE_DIR})
set(LibVNCServer_Server_INCLUDE_DIRS ${LibVNCServer_INCLUDE_DIR})



macro(libvnc__find_library name)

    string(TOLOWER ${name} libName)


    find_library(
        LibVNCServer_${name}_LIBRARY_RELEASE
        NAMES vnc${libName}
        HINTS ${_LibVNCServer_path_to_search}
        )

    find_library(
        LibVNCServer_${name}_LIBRARY_DEBUG
        NAMES vnc${libName}d
        HINTS ${_LibVNCServer_path_to_search}
        )

    set(LibVNCServer_${name}_LIBRARIES
        ${LibVNCServer_${name}_LIBRARY_RELEASE}
        ${LibVNCServer_${name}_LIBRARY_DEBUG}
        )

    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(
        LibVNCServer_${name} FOUND_VAR LibVNCServer_${name}_FOUND
        REQUIRED_VARS
            LibVNCServer_${name}_INCLUDE_DIRS
            LibVNCServer_${name}_LIBRARIES
        )

    if (NOT LibVNCServer_${name}_FOUND)
        return()
    endif()


    if (LibVNCServer_${name}_LIBRARY_RELEASE)
        cmut__find__import_target(LibVNCServer ${name}
            LANGUAGE "CXX"
            INCLUDE_DIR "${LibVNCServer_INCLUDE_DIR}"
            CONFIG RELEASE
            LIBRARY "${LibVNCServer_Client_LIBRARY_RELEASE}"
            DEFAULT
            )
    endif()

    if (LibVNCServer_${name}_LIBRARY_DEBUG)
        if (NOT LibVNCServer_${name}_LIBRARY_RELEASE)
            set(OPT DEFAULT)
        endif()

        cmut__find__import_target(LibVNCServer ${name}
            LANGUAGE "CXX"
            INCLUDE_DIR "${LibVNCServer_INCLUDE_DIR}"
            CONFIG DEBUG
            LIBRARY "${LibVNCServer_Client_LIBRARY_DEBUG}"
            ${OPT}
            LINK_LIBRARIES OpenSSL::SSL OpenSSL::Crypto JPEG::JPEG PNG::PNG ZLIB::ZLIB
            )
    endif()


endmacro()


find_package(OpenSSL)
find_package(JPEG)
find_package(PNG)
find_package(ZLIB)


libvnc__find_library( Client )
libvnc__find_library( Server )
