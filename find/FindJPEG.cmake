# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#.rst:
# FindJPEG
# --------
#
# Find JPEG
#
# Find the native JPEG includes and library This module defines
#
# ::
#
#   JPEG_INCLUDE_DIR, where to find jpeglib.h, etc.
#   JPEG_LIBRARIES, the libraries needed to use JPEG.
#   JPEG_FOUND, If false, do not try to use JPEG.
#
# also defined, but not for general use are
#
# ::
#
#   JPEG_LIBRARY, where to find the JPEG library.

find_path(JPEG_INCLUDE_DIR jpeglib.h)

set(JPEG_NAMES ${JPEG_NAMES} jpeg libjpeg)
find_library(JPEG_LIBRARY NAMES ${JPEG_NAMES} )

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(JPEG DEFAULT_MSG JPEG_LIBRARY JPEG_INCLUDE_DIR)

if(JPEG_FOUND)
  set(JPEG_LIBRARIES ${JPEG_LIBRARY})
endif()



# Deprecated declarations.
set (NATIVE_JPEG_INCLUDE_PATH ${JPEG_INCLUDE_DIR} )
if(JPEG_LIBRARY)
  get_filename_component (NATIVE_JPEG_LIB_PATH ${JPEG_LIBRARY} PATH)
endif()

mark_as_advanced(JPEG_LIBRARY JPEG_INCLUDE_DIR )


if(JPEG_FOUND)
    set(JPEG_INCLUDE_DIRS ${JPEG_INCLUDE_DIR})

    if(NOT JPEG_LIBRARIES)
      set(JPEG_LIBRARIES ${JPEG_LIBRARY})
    endif()

    if(NOT TARGET JPEG::JPEG)
      add_library(JPEG::JPEG UNKNOWN IMPORTED)
      set_target_properties(JPEG::JPEG PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${JPEG_INCLUDE_DIRS}")

      if(JPEG_LIBRARY_RELEASE)
        set_property(TARGET JPEG::JPEG APPEND PROPERTY
          IMPORTED_CONFIGURATIONS RELEASE)
        set_target_properties(JPEG::JPEG PROPERTIES
          IMPORTED_LOCATION_RELEASE "${JPEG_LIBRARY_RELEASE}")
      endif()

      if(JPEG_LIBRARY_DEBUG)
        set_property(TARGET JPEG::JPEG APPEND PROPERTY
          IMPORTED_CONFIGURATIONS DEBUG)
        set_target_properties(JPEG::JPEG PROPERTIES
          IMPORTED_LOCATION_DEBUG "${JPEG_LIBRARY_DEBUG}")
      endif()

      if(NOT JPEG_LIBRARY_RELEASE AND NOT JPEG_LIBRARY_DEBUG)
        set_property(TARGET JPEG::JPEG APPEND PROPERTY
          IMPORTED_LOCATION "${JPEG_LIBRARY}")
      endif()
    endif()
endif()
