include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)



# Active Qml debugger when build type is Debug
function(cmut__build__enable_qml_debugger)

    if ( ( CMAKE_BUILD_TYPE STREQUAL "Debug" ) OR ( CMAKE_BUILD_TYPE STREQUAL "Coverage" ) )
        set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -DQT_QML_DEBUG ")

    else()
        cmut_error( "[cmut] - qml debugger can't be use in other BUILD_TYPE than Debug or Coverage, you currently BUILD_TYPE is ${CMAKE_BUILD_TYPE}" )

    endif()

    cmut_info("[cmut] - qml debugger is active, don't forget to active project option in run mode")

endfunction()
