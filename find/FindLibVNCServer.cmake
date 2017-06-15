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



find_library(LibVNCServer_Client_LIBRARY vncclient vncclientd
    HINTS ${_LibVNCServer_path_to_search}
    PATH_SUFFIXES lib lib64
)

#find_package(OpenSSL)
#find_package(JPEG)
find_package(ZLIB)

set(LibVNCServer_Client_LIBRARIES ${LibVNCServer_Client_LIBRARY} ${ZLIB_LIBRARIES})


find_library(LibVNCServer_Server_LIBRARY vncserver
    HINTS ${_LibVNCServer_path_to_search}
    PATH_SUFFIXES lib lib64
)
set(LibVNCServer_Server_LIBRARIES ${LibVNCServer_Server_LIBRARY})



include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    LibVNCServer_Client FOUND_VAR LibVNCServer_Client_FOUND
    REQUIRED_VARS
        LibVNCServer_Client_INCLUDE_DIRS
        LibVNCServer_Client_LIBRARIES
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    LibVNCServer_Server FOUND_VAR LibVNCServer_Server_FOUND
    REQUIRED_VARS
        LibVNCServer_Server_INCLUDE_DIRS
        LibVNCServer_Server_LIBRARIES
)





if(ZLIB_FOUND)
    list(APPEND dependencies_library ${ZLIB_LIBRARIES})
endif()

if(LibVNCServer_CLient_FOUND)

    set(target_name libvncserver::client)

    add_library(${target_name} UNKNOWN IMPORTED)
    set_target_properties(
        ${target_name}
            PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${LibVNCServer_Client_INCLUDE_DIRS}"
        )

    set_target_properties(
        ${target_name}
            PROPERTIES
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
                IMPORTED_LOCATION "${LibVNCServer_Client_LIBRARY}"
                INTERFACE_LINK_LIBRARIES ${dependencies_library}
        )
endif()
