

        message("CMAKE_CURRENT_LIST_FILE = ${CMAKE_CURRENT_LIST_FILE}")
        message("CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")



include(${CMAKE_CURRENT_LIST_DIR}/function/cmut_define_uninstall_target.cmake)
cmut_define_uninstall_target()
