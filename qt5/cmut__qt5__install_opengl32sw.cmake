

function(cmut__qt5__download_opengl32sw result)

    find_file(7Z_COMMAND NAMES 7z 7z.exe)
    if(NOT 7Z_COMMAND)
        cmut_error("7z executable is required to unzip opengl32sw archive.")
    endif()

    set(TMP_DIR "${PROJECT_BINARY_DIR}/tmp")

    set(OPENGL32SW_7Z_FILE "${TMP_DIR}/opengl32sw.7z")
    set(OPENGL32SW_FILE "${TMP_DIR}/opengl32sw.dll")

    file(DOWNLOAD
        "http://download.qt.io/development_releases/prebuilt/llvmpipe/windows/opengl32sw-32-mesa_11_2_2.7z"
        "${OPENGL32SW_7Z_FILE}"
        SHOW_PROGRESS
        EXPECTED_HASH SHA1=e742e9d4e16b9c69b6d844940861d3ef1748356b)



    execute_process(
        COMMAND "${CMAKE_COMMAND}" -E remove -f "${OPENGL32SW_FILE}"
        WORKING_DIRECTORY "${TMP_DIR}"
        RESULT_VARIABLE remove_result
        OUTPUT_VARIABLE remove_output
        ERROR_VARIABLE remove_error
        )

    if(remove_result)
        cmut_info("fail to remove ${OPENGL32SW_FILE}")
        cmut_info("result : ${remove_result}")
        cmut_info("output : ${remove_output}")
        cmut_info("error  : ${remove_error}")
        cmut_fatal("error")
    endif()


    file(TO_NATIVE_PATH "${OPENGL32SW_7Z_FILE}" OPENGL32SW_7Z_FILE__NATIVE_PATH)

    cmut__utils__find_program(7z REQUIRED)
    cmut_info("7Z_CMD = ${7Z_CMD}")
    execute_process(
        COMMAND "${7Z_CMD}" x "${OPENGL32SW_7Z_FILE__NATIVE_PATH}"
        WORKING_DIRECTORY "${TMP_DIR}"
        RESULT_VARIABLE 7z_result
        OUTPUT_VARIABLE 7z_output
        ERROR_VARIABLE 7z_error
        )

    if(7z_result)
        cmut_info("7z used :  ${7Z_CMD}")
        cmut_info("fail to decompress ${OPENGL32SW_7Z_FILE}")
        cmut_info("result : ${7z_result}")
        cmut_info("output : ${7z_output}")
        cmut_info("error  : ${7z_error}")
        cmut_fatal("error")
    endif()

    set(${result} "${OPENGL32SW_FILE}" PARENT_SCOPE)

endfunction()



function(cmut__qt5__install_opengl32sw)

    cmut__utils__parse_arguments(
        cmut__qt5__install_opengl32sw
        ARG
        ""
        "DESTINATION;COMPONENT"
        ""
        ${ARGN}
        )

    if(NOT DEFINED ARG_DESTINATION)
        cmut_debug("[cmut][qt5][install_opengl32sw] - DESTINATION is required.")
    endif()

    cmut__qt5__download_opengl32sw(OPENGL32SW_FILE)

    install(
        FILES
            ${OPENGL32SW_FILE}
        DESTINATION "${ARG_DESTINATION}"
        COMPONENT "${ARG_COMPONENT}"
        )

endfunction()

function(cmut__qt5__install_angle)

    cmut__utils__parse_arguments(
        cmut__qt5__install_angle
        ARG
        ""
        "DESTINATION;COMPONENT"
        ""
        ${ARGV}
        )

    if(NOT DEFINED ARG_DESTINATION)
        cmut_debug("[cmut][qt5][install_angle] - DESTINATION is required.")
    endif()

    list(APPEND CMAKE_MODULE_PATH "${CMUT_ROOT}/find")
    find_package(WindowsSDK REQUIRED)

    cmut__qt5__get_qmake_property(QT5_INSTALL_PREFIX INSTALL_PREFIX)



    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        set(QT_LIB_POSTFIX d)
    else()
        set(QT_LIB_POSTFIX)
    endif()

    set(files_to_install)
    if(EXISTS "${QT5_INSTALL_PREFIX}/bin/libEGL${QT_LIB_POSTFIX}.dll")
        list(APPEND files_to_install "${QT5_INSTALL_PREFIX}/bin/libEGL${QT_LIB_POSTFIX}.dll")
    endif()
    if(EXISTS "${QT5_INSTALL_PREFIX}/bin/libGLESv2${QT_LIB_POSTFIX}.dll")
        list(APPEND files_to_install "${QT5_INSTALL_PREFIX}/bin/libGLESv2${QT_LIB_POSTFIX}.dll")
    endif()

    install(
        FILES
            ${files_to_install}
            ${D3DCOMPILER_DLL}
        DESTINATION "${ARG_DESTINATION}"
        COMPONENT "${ARG_COMPONENT}"
        )

endfunction()
