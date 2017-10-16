include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)

function(cmut__utils__rmdir DIR_NAME)

    if(EXISTS "${DIR_NAME}" AND NOT CONTINUE)

        cmut_info("rm -rf ${DIR_NAME}")
        file(REMOVE_RECURSE "${DIR_NAME}")

        if(EXISTS "${DIR_NAME}")
            cmut_fatal("Fail to remove \"${DIR_NAME}\" directory. Abort.")
            return()
        endif()

    endif()

endfunction()



function(cmut__utils__mkdir DIR_NAME)

    if(NOT EXISTS "${DIR_NAME}")

        cmut_info("mkdir ${DIR_NAME}")
        file(MAKE_DIRECTORY "${DIR_NAME}")

        if(NOT EXISTS "${DIR_NAME}")
            cmut_fatal("Fail to create \"${DIR_NAME}\" directory. Abort.")
            return()
        endif()

    endif()

endfunction()



function(cmut__utils__reset_dir DIR_NAME)

    cmut__utils__rmdir("${DIR_NAME}")
    cmut__utils__mkdir("${DIR_NAME}")

endfunction()
