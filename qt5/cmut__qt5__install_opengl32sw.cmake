

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
        COMMAND "7z" "x" "${OPENGL32SW_7Z_FILE}"
        WORKING_DIRECTORY ${TMP_DIR}
        RESULT_VARIABLE 7z_result
        OUTPUT_VARIABLE 7z_output
        ERROR_VARIABLE 7z_error
        )

    if(7z_result)
        cmut_info("fail to decompress ${OPENGL32SW_FILE}")
        cmut_info("output : ${OUTPUT_VARIABLE}")
        cmut_info("error : ${ERROR_VARIABLE}")
        cmut_fatal("output : ${OUTPUT_VARIABLE}")
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
    find_package(D3Dcompiler)

    cmut__qt5__get_qmake_property(QT5_INSTALL_PREFIX INSTALL_PREFIX)

    
    install(
        FILES
            ${QT5_INSTALL_PREFIX}/bin/libEGL$<$<CONFIG:Debug>:d>.dll
            ${QT5_INSTALL_PREFIX}/bin/libGLESv2$<$<CONFIG:Debug>:d>.dll
            ${D3DCOMPILER}
        DESTINATION "${ARG_DESTINATION}"
        COMPONENT "${ARG_COMPONENT}"
        )

endfunction()
