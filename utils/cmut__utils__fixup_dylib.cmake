include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()

cmake_policy(SET CMP0011 NEW)
cmake_policy(SET CMP0054 NEW)


include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__parse_arguments.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__find_program.cmake)


function(cmut__otool__get_id result dylib)

    cmut__utils__find_program(install_name_tool REQUIRED)
    cmut__utils__find_program(otool REQUIRED)

    get_filename_component(dylib "${dylib}" REALPATH)
    if(NOT EXISTS "${item}")
        cmut_warn("[cmut][otool][get_id] - file \"${dylib}\" not found.")
        return()
    endif()

    execute_process(
        COMMAND "${OTOOL_CMD}" -DX "${dylib}"
        OUTPUT_VARIABLE id_value
        )

    # remove end line
    string(REPLACE "\n" "" id_value "${id_value}")

    set(${result} ${id_value} PARENT_SCOPE)

endfunction()


function(cmut__utils__fixup_dylib_id item)

    cmut__otool__get_id(id "${item}")

    # if no id, return
    if("${id_value}" STREQUAL "")
        return()
    endif()


    get_filename_component(filename "${id_value}" NAME)
    set(rpath_filename "@rpath/${filename}")

    if(NOT rpath_filename STREQUAL id_value)

        execute_process(
            COMMAND "${INSTALL_NAME_TOOL_CMD}" -id "${rpath_filename}" "${item}"
	    RESULT_VARIABLE cmd_result
            OUTPUT_VARIABLE id_value
            )

        if(cmd_result EQUAL 0)
            cmut_info("[cmut][utils][fixup_dylib] - ${item} id: ${id_value} ==>> ${rpath_filename}")
        else()
            cmut_error("[cmut][utils][fixup_dylib] - ${item} id failed")
        endif()

    endif()

endfunction()



function(cmut__utils__fixup_dylib_dependencies item install_dir)


    cmut__utils__find_program(install_name_tool REQUIRED)
    cmut__utils__find_program(otool REQUIRED)

    get_filename_component(item "${item}" REALPATH)
    if(NOT EXISTS "${item}")
        cmut_warning("[cmut][utils][fixup_dylib] - file ${item} not found. Fixup dylib id skipped.")
        return()
    endif()

    execute_process(
        COMMAND "${OTOOL_CMD}" -XL "${item}"
        OUTPUT_VARIABLE dependencies_value
        )

    # split end line
    string(REPLACE "\n" ";" dependencies_value ${dependencies_value})
    cmut_debug("[cmut][utils][fixup_dylib] - dependencies_value = ${dependencies_value}")


    cmut__otool__get_id(item_id "${item}")
    get_filename_component(item_dirname "${item}" DIRECTORY)


    foreach(dependency ${dependencies_value})
        cmut_debug("[cmut][utils][fixup_dylib] - dependency = ${dependency}")

        # remove (compatibility ...)
        string(REGEX REPLACE " *\\(compatibility.*\\)$" " " dependency ${dependency})

        # strip
        string(STRIP ${dependency} dependency)
        cmut_debug("[cmut][utils][fixup_dylib] - cleaned dependency = ${dependency}")

        if("${item_id}" STREQUAL "${dependency}")
	    cmut_debug("[cmut][utils][fixup_dylib] - dependency == dylib's id, skipped.")
            continue()
        endif()



        get_filename_component(dirname "${dependency}" DIRECTORY)
        if (dirname AND (NOT "${dependency}" MATCHES "^${install_dir}/.*$"))
	    cmut_debug("[cmut][utils][fixup_dylib] - dirname\(${dirname}\) != install_dir\(${install_dir}\)")
	    continue()
	endif()


	if (dirname)
            file(RELATIVE_PATH dylib_dir_to_dependency "${item_dirname}" "${dependency}")
	    set(rpath_filename "@rpath/${dylib_dir_to_dependency}")
        else()
            set(rpath_filename "@rpath/${dependency}")
        endif()
        cmut_debug("[cmut][utils][fixup_dylib] - rpath_filename = ${rpath_filename}")


        if(NOT rpath_filename STREQUAL id_value)

            execute_process(
                COMMAND "${INSTALL_NAME_TOOL_CMD}" -change "${dependency}" "${rpath_filename}" "${item}"
	        RESULT_VARIABLE cmd_result
                OUTPUT_VARIABLE id_value
                )

            if(cmd_result EQUAL 0)
                cmut_info("[cmut][utils][fixup_dylib] - ${item} : change ${dependency} ==>> ${rpath_filename}")
            else()
                cmut_error("[cmut][utils][fixup_dylib] - ${item} : change of ${dependency} failed")
            endif()
        endif()

    endforeach()

endfunction()


function(cmut__utils__install_name_tool output )

    cmut__utils__find_program(install_name_tool REQUIRED)

    execute_process(
        COMMAND "${INSTALL_NAME_TOOL_CMD}" ${ARGN}
	RESULT_VARIABLE cmd_result
        OUTPUT_VARIABLE cmd_output
	ERROR_VARIABLE cmd_error
    )

    if(NOT cmd_result EQUAL 0)
        cmut_info(
	    "execute_process(
	    COMMAND \"${INSTALL_NAME_TOOL_CMD}\" ${ARGN}
	    RESULT_VARIABLE cmd_result
            OUTPUT_VARIABLE cmd_output)
            result == ${cmd_result}
            output == \"${cmd_output}\"
            error  == \"${cmd_error}\""
	    )

        cmut_error("cmut__utils__install_name_tool : install_name_tool ${args} failed.")
    endif()

    set(${output} ${cmd_output} PARENT_SCOPE)

endfunction()
