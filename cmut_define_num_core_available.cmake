# define CMUT_NUM_CORE_AVAILABLE with number of available core on this machine
# 
# CMUT_NUM_CORE_AVAILABLE is guarantee to be at least equal to 1 



if(__cmut_define_num_core_available__defined)
    return()
endif()


include(ProcessorCount)
ProcessorCount(__cmut_num_core_available)

if( (__cmut_num_core_available EQUAL 0) OR (__cmut_num_core_available LESS 0) )
    set(__cmut_num_core_available 1)
endif()

set(CMUT_NUM_CORE_AVAILABLE ${__cmut_num_core_available} CACHE STRING "number of parallel job used to build")

set(__cmut_define_num_core_available__defined 1)