# define CMUT_NUM_CORE_AVAILABLE with number of available core on this machine
#
# CMUT_NUM_CORE_AVAILABLE is guarantee to be at least equal to 1


if(DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)
    return()
endif()
set(${CMAKE_CURRENT_LIST_FILE}_include "1")

cmut_info("cmut_define_num_core_available is deprecated, use system/cmut__system__num_core_available.cmake instead")



include("${CMAKE_CURRENT_LIST_DIR/system/cmut__system__num_core_available.cmake}")

cmut__system__get_num_core_available(__cmut_num_core_available)
set(CMUT_NUM_CORE_AVAILABLE ${__cmut_num_core_available} CACHE STRING "number of parallel job used to build")
