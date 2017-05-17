include("${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake")



function(cmut__config__log_project_begin)

    cmut_info("--------------------------------------------------------------------------------")
    cmut_info("begin ${PROJECT_NAME} - ${${PROJECT_NAME}_VERSION} configuration")
    cmut_info("--------------------------------------------------------------------------------")

endfunction()

function(cmut__config__log_project_end)

    cmut_info("--------------------------------------------------------------------------------")
    cmut_info("end ${PROJECT_NAME} - ${${PROJECT_NAME}_VERSION} configuration")
    cmut_info("--------------------------------------------------------------------------------")

endfunction()
