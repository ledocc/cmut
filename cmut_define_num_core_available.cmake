# define CMUT_NUM_CORE_AVAILABLE with number of available core on this machine
# 
# CMUT_NUM_CORE_AVAILABLE is guarantee to be at least equal to 1 



if(__cmut_define_num_core_available__defined)
    return()
endif()


include(ProcessorCount)
ProcessorCount(CMUT_NUM_CORE_AVAILABLE)

if( (CMUT_NUM_CORE_AVAILABLE EQUAL 0) OR (CMUT_NUM_CORE_AVAILABLE LESS 0) )
    set(CMUT_NUM_CORE_AVAILABLE 1)
endif()



set(__cmut_define_num_core_available__defined 1)