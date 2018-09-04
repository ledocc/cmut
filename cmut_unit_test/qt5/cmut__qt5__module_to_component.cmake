
include( "${CMAKE_CURRENT_LIST_DIR}/../../qt5/cmut__qt5__module_and_component.cmake" )

function(cmut_test__qt5__get_component_for_module)

    cmut__qt5__get_component_for_module(component "Core")

    if( component STREQUAL "qtbase")
        message(STATUS "cmut__qt5__get_component_for_module OK")
    else()
        message(WARNING "cmut__qt5__get_component_for_module KO")
        message(STATUS "cmut__qt5__get_component_for_module return \"${component}\" instead of \"qtbase\"")
    endif()


    cmut__qt5__get_component_for_module(component "Coreee")

    if( NOT component )
        message(STATUS "cmut__qt5__get_component_for_module OK")
    else()
        message(WARNING "cmut__qt5__get_component_for_module KO")
        message(STATUS "cmut__qt5__get_component_for_module return \"${component}\" instead of \"\"")
    endif()

endfunction()


cmut_test__qt5__get_component_for_module()
