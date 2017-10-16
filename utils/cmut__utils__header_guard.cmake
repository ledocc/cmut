if(DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)
    return()
endif()
set(${CMAKE_CURRENT_LIST_FILE}_include "1")



macro(cmut__utils__define_header_guard)

    if(DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)
        return()
    endif()
    set(${CMAKE_CURRENT_LIST_FILE}_include "1")

endmacro()
