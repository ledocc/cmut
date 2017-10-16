include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



include(${CMAKE_CURRENT_LIST_DIR}/cmut__install__define_variables.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__parse_arguments.cmake)


# config file should be installed in
# - build tree to be used in developper mode
# - install tree to be used in package mode
function(cmut__install__install_config_file)

    cmut__utils__parse_arguments(cmut__install__install_config_files
                                 __ARGS
                                 ""
                                 "DESTINATION"
                                 "FILES"
                                 ${ARGN})

    if(__ARGS_FILES STREQUAL "")
        return()
    endif()

    __cmut__install__define_variables()


    foreach(file ${__ARGS_FILES})

        get_filename_component(filename "${file}" NAME)
        set(install_dir "${cmut__install__config_dir}/${__ARGS_DESTINATION}")

        if(CMUT__CONFIG__DEVELOPER_MODE)
            configure_file("${file}" "${install_dir}/${filename}" COPYONLY)
        endif()

        install(
            FILES       "${file}"
            DESTINATION "${install_dir}"
            COMPONENT    devel
        )

    endforeach()

endfunction()
