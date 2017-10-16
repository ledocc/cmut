include(${CMAKE_CURRENT_LIST_DIR}/../../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



# This option is to enable the /MP switch for Visual Studio 2005 and above compilers
function(cmut__build__msvc__option_use_mp)

    if(MSVC)

        option(CMUT__BUILD__MSVC__USE_MP "Set to ON to build with the /MP option (Visual Studio)." ON)
        mark_as_advanced(CMUT__BUILD__MSVC__USE_MP)

        if(CMUT__BUILD__MSVC__USE_MP)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP" PARENT_SCOPE)
        endif()

    endif()

endfunction()
