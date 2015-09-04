
#------------------------------------------------------------------------------
# define look for cmut root directory and add it to CMAKE_MODULE_PATH
#------------------------------------------------------------------------------

find_path( CMUT_PATH cmut.cmake
           HINTS $ENV{CMUT_ROOT}
		   DOC "Path to cmut directory project"
		   NO_DEFAULT_PATH )

if(NOT CMUT_PATH)
    message(FATAL_ERROR "cmut not found, define CMUT_ROOT environement variable to automatically found CMake Utility Toolkit (cmut)")
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMUT_PATH})