include(${CMAKE_CURRENT_LIST_DIR}/../../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



# this function allow user to define which winnt version to use
function(cmut__build__win32__set_winnt_version version)

    if(WIN32)

        if(${version} STREQUAL "")
            set(version "0x601")
        endif()

        set(CMUT__BUILD__WIN32__WINNT_VERSION ${version} PARENT_SCOPE)
        add_definitions(-D_WIN32_WINNT=${version})

    endif()

endfunction()
