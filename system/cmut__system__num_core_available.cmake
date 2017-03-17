if(DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)
    return()
endif()
set(${CMAKE_CURRENT_LIST_FILE}_include "1")


include(ProcessorCount)

function(cmut__system__get_num_core_available result)
    ProcessorCount(__cmut_num_core_available)

    if(__cmut_num_core_available LESS 1)
        set(__cmut_num_core_available 1)
    endif()

    set(${result} ${__cmut_num_core_available} PARENT_SCOPE)
endfunction()
