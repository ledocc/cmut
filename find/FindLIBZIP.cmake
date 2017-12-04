# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#.rst:
# FindLIBZIP
# --------
#
# Find the native LIBZIP includes and library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines :prop_tgt:`IMPORTED` target ``LIBZIP::LIBZIP``, if
# LIBZIP has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   LIBZIP_INCLUDE_DIRS   - where to find zlib.h, etc.
#   LIBZIP_LIBRARIES      - List of libraries when using zlib.
#   LIBZIP_FOUND          - True if zlib found.
#
# ::
#
#   LIBZIP_VERSION_STRING - The version of zlib found (x.y.z)
#   LIBZIP_VERSION_MAJOR  - The major version of zlib
#   LIBZIP_VERSION_MINOR  - The minor version of zlib
#   LIBZIP_VERSION_PATCH  - The patch version of zlib
#   LIBZIP_VERSION_TWEAK  - The tweak version of zlib
#
# Backward Compatibility
# ^^^^^^^^^^^^^^^^^^^^^^
#
# The following variable are provided for backward compatibility
#
# ::
#
#   LIBZIP_MAJOR_VERSION  - The major version of zlib
#   LIBZIP_MINOR_VERSION  - The minor version of zlib
#   LIBZIP_PATCH_VERSION  - The patch version of zlib
#
# Hints
# ^^^^^
#
# A user may set ``LIBZIP_ROOT`` to a zlib installation root to tell this
# module where to look.

set(_LIBZIP_SEARCHES)

# Search LIBZIP_ROOT first if it is set.
if(LIBZIP_ROOT)
  set(_LIBZIP_SEARCH_ROOT PATHS ${LIBZIP_ROOT} NO_DEFAULT_PATH)
  list(APPEND _LIBZIP_SEARCHES _LIBZIP_SEARCH_ROOT)
endif()

# Normal search.
list(APPEND _LIBZIP_SEARCHES _LIBZIP_SEARCH_NORMAL)

set(LIBZIP_NAMES zip)
set(LIBZIP_NAMES_DEBUG zipd)

# Try each search configuration.
foreach(search ${_LIBZIP_SEARCHES})
  find_path(LIBZIP_INCLUDE_DIR NAMES zip.h ${${search}} PATH_SUFFIXES include NO_CMAKE_FIND_ROOT_PATH)
endforeach()

# Allow LIBZIP_LIBRARY to be set manually, as the location of the libzip library
if(NOT LIBZIP_LIBRARY)
  foreach(search ${_LIBZIP_SEARCHES})
    find_library(LIBZIP_LIBRARY_RELEASE NAMES ${LIBZIP_NAMES} ${${search}} PATH_SUFFIXES lib NO_CMAKE_FIND_ROOT_PATH)
    find_library(LIBZIP_LIBRARY_DEBUG NAMES ${LIBZIP_NAMES_DEBUG} ${${search}} PATH_SUFFIXES lib NO_CMAKE_FIND_ROOT_PATH)
  endforeach()

  include(SelectLibraryConfigurations)
  select_library_configurations(LIBZIP)
endif()

unset(LIBZIP_NAMES)
unset(LIBZIP_NAMES_DEBUG)

mark_as_advanced(LIBZIP_INCLUDE_DIR)

if(LIBZIP_INCLUDE_DIR AND EXISTS "${LIBZIP_INCLUDE_DIR}/zipconf.h")
    file(STRINGS "${LIBZIP_INCLUDE_DIR}/zipconf.h" LIBZIP_H REGEX "^#define LIBZIP_VERSION \"[^\"]*\"$")

    string(REGEX REPLACE "^.*LIBZIP_VERSION \"([0-9]+).*$" "\\1" LIBZIP_VERSION_MAJOR "${LIBZIP_H}")
    string(REGEX REPLACE "^.*LIBZIP_VERSION \"[0-9]+\\.([0-9]+).*$" "\\1" LIBZIP_VERSION_MINOR  "${LIBZIP_H}")
    string(REGEX REPLACE "^.*LIBZIP_VERSION \"[0-9]+\\.[0-9]+\\.([0-9]+).*$" "\\1" LIBZIP_VERSION_PATCH "${LIBZIP_H}")
    set(LIBZIP_VERSION_STRING "${LIBZIP_VERSION_MAJOR}.${LIBZIP_VERSION_MINOR}.${LIBZIP_VERSION_PATCH}")

    # only append a TWEAK version if it exists:
    set(LIBZIP_VERSION_TWEAK "")
    if( "${LIBZIP_H}" MATCHES "LIBZIP_VERSION \"[0-9]+\\.[0-9]+\\.[0-9]+\\.([0-9]+)")
        set(LIBZIP_VERSION_TWEAK "${CMAKE_MATCH_1}")
        string(APPEND LIBZIP_VERSION_STRING ".${LIBZIP_VERSION_TWEAK}")
    endif()

    set(LIBZIP_MAJOR_VERSION "${LIBZIP_VERSION_MAJOR}")
    set(LIBZIP_MINOR_VERSION "${LIBZIP_VERSION_MINOR}")
    set(LIBZIP_PATCH_VERSION "${LIBZIP_VERSION_PATCH}")
endif()

# handle the QUIETLY and REQUIRED arguments and set LIBZIP_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(LIBZIP REQUIRED_VARS LIBZIP_LIBRARY LIBZIP_INCLUDE_DIR
                                       VERSION_VAR LIBZIP_VERSION_STRING)

if(LIBZIP_FOUND)
    set(LIBZIP_INCLUDE_DIRS ${LIBZIP_INCLUDE_DIR})

    if(NOT LIBZIP_LIBRARIES)
      set(LIBZIP_LIBRARIES ${LIBZIP_LIBRARY})
    endif()

    if(NOT TARGET LIBZIP::LIBZIP)
      add_library(LIBZIP::LIBZIP UNKNOWN IMPORTED)
      set_target_properties(LIBZIP::LIBZIP PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${LIBZIP_INCLUDE_DIRS}")

      if(LIBZIP_LIBRARY_RELEASE)
        set_property(TARGET LIBZIP::LIBZIP APPEND PROPERTY
          IMPORTED_CONFIGURATIONS RELEASE)
        set_target_properties(LIBZIP::LIBZIP PROPERTIES
          IMPORTED_LOCATION_RELEASE "${LIBZIP_LIBRARY_RELEASE}")
      endif()

      if(LIBZIP_LIBRARY_DEBUG)
        set_property(TARGET LIBZIP::LIBZIP APPEND PROPERTY
          IMPORTED_CONFIGURATIONS DEBUG)
        set_target_properties(LIBZIP::LIBZIP PROPERTIES
          IMPORTED_LOCATION_DEBUG "${LIBZIP_LIBRARY_DEBUG}")
      endif()

      if(NOT LIBZIP_LIBRARY_RELEASE AND NOT LIBZIP_LIBRARY_DEBUG)
        set_property(TARGET LIBZIP::LIBZIP APPEND PROPERTY
          IMPORTED_LOCATION "${LIBZIP_LIBRARY}")
      endif()
    endif()
endif()
