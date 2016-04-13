#------------------------------------------------------------------------------
# define CMAKE_*_OUTPUT_DIRECTORY
#------------------------------------------------------------------------------


include( cmut_determine_lib_postfix )


# TODO on MacOS, define function for bundle, Framework and regular bin
macro( cmut_define_output_dirs )

    set(BASE_DIR ${CMAKE_BINARY_DIR})
    if(${ARGC} GREATER 0)
        set(BASE_DIR ${ARGV0})
    endif()

    if( NOT DEFINED CMUT_LIB_POSTFIX )
        cmut_determine_lib_postfix()
    endif()

    if(CMAKE_HOST_APPLE)
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${BASE_DIR})
    else()
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${BASE_DIR}/bin)
    endif()

    if(WIN32)
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${BASE_DIR}/bin)
    else()
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${BASE_DIR}/lib${CMUT_LIB_POSTFIX})
    endif()
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${BASE_DIR}/lib${CMUT_LIB_POSTFIX})

    set(CMUT_DEFINE_OUTPUT_DIRS_DONE 1)
    mark_as_advanced(CMUT_DEFINE_OUTPUT_DIRS_DONE)

endmacro()
