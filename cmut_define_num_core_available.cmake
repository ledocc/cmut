# define CMUT_NUM_CORE_AVAILABLE with number of available core on this machine
#
# CMUT_NUM_CORE_AVAILABLE is guarantee to be at least equal to 1


if(DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)
    return()
endif()
set(${CMAKE_CURRENT_LIST_FILE}_include "1")


cmake_host_system_information(
    RESULT __cmut_num_core_available
    QUERY  NUMBER_OF_LOGICAL_CORES)

if(__cmut_num_core_available LESS 1)
    set(__cmut_num_core_available 1)
endif()

set(CMUT_NUM_CORE_AVAILABLE ${__cmut_num_core_available} CACHE STRING "number of parallel job used to build")
