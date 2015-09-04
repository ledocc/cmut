#------------------------------------------------------------------------------
# define CMAKE_*_OUTPUT_DIRECTORY
#------------------------------------------------------------------------------


include( cmut_determine_lib_postfix )

macro( cmut_define_output_dirs )

    if( NOT DEFINED CMUT_LIB_POSTFIX )
        cmut_determine_lib_postfix()
    endif()

    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
    if(WIN32)
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
    else()
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib${CMUT_LIB_POSTFIX})
    endif()
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib${CMUT_LIB_POSTFIX})

    set(CMUT_DEFINE_OUTPUT_DIRS_DONE 1)
    mark_as_advanced(CMUT_DEFINE_OUTPUT_DIRS_DONE)
    
endmacro()