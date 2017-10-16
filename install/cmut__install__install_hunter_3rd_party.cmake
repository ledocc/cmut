include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()


include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmut__install__define_variables.cmake)

function(cmut__install__install_hunter_3rd_party)

    set(HUNTER_3RDPARTY_INFO_FILE "${CMAKE_BINARY_DIR}/_3rdParty/Hunter/install-root-dir")


    if(NOT EXISTS "${HUNTER_3RDPARTY_INFO_FILE}")
        cmut_warn("can't found \"${HUNTER_3RDPARTY_INFO_FILE}\" file. Hunter 3rd party installation skipped.")
        return()
    endif()

    file(READ "${HUNTER_3RDPARTY_INFO_FILE}" HUNTER_INSTALL_PREFIX)
#    message("HUNTER_INSTALL_PREFIX = ${HUNTER_INSTALL_PREFIX}")

    if(NOT EXISTS "${HUNTER_INSTALL_PREFIX}")
        cmut_warn("can't found \"${HUNTER_INSTALL_PREFIX}\" directory. Hunter 3rd party installation skipped.")
        return()
    endif()



    file(
        GLOB HUNTER_INSTALL_DIR_LIST
        RELATIVE "${HUNTER_INSTALL_PREFIX}"
        "${HUNTER_INSTALL_PREFIX}/*"
    )

#    message("HUNTER_INSTALL_DIR_LIST = ${HUNTER_INSTALL_DIR_LIST}")
    list(LENGTH HUNTER_INSTALL_DIR_LIST HUNTER_INSTALL_DIR_LIST_LENGTH)
    if(NOT ${HUNTER_INSTALL_DIR_LIST_LENGTH})
        cmut_warn("${HUNTER_INSTALL_PREFIX} directory is empty. no Hunter 3rd party to install.")
        return()
    endif()

    __cmut__install__define_variables()

    foreach(__dir ${HUNTER_INSTALL_DIR_LIST})

        if("${__dir}" STREQUAL "include")
            set(__component_directive COMPONENT devel)
        endif()

        install(
            DIRECTORY   "${HUNTER_INSTALL_PREFIX}/${__dir}"
            DESTINATION "."
            ${__component_directive}
        )

    endforeach()

endfunction()
