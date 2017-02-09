include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()

cmake_policy(SET CMP0011 NEW)
cmake_policy(SET CMP0054 NEW)


include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__parse_arguments.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__find_program.cmake)


function(cmut__utils__fixup_dylib_id item)

    cmut__utils__find_program(install_name_tool REQUIRED)
    cmut__utils__find_program(otool REQUIRED)

    get_filename_component(item "${item}" REALPATH)
    if(NOT EXISTS "${item}")
        cmut_warn("file ${item} not found. Fixup dylib id skipped.")
        return()
    endif()

    execute_process(
        COMMAND "${OTOOL_CMD}" -D "${item}"
        OUTPUT_VARIABLE id_value
        )


    # remove <file path:>
    string(REGEX REPLACE "[^\n]*:\n" "" id_value ${id_value})

    # remove end line
    string(REPLACE "\n" "" id_value "${id_value}")

    get_filename_component(filename "${id_value}" NAME)
    set(rpath_filename "@rpath/${filename}")

    if(NOT rpath_filename STREQUAL id_value)
    
        execute_process(
            COMMAND "${INSTALL_NAME_TOOL_CMD}" -id "${rpath_filename}" "${item}"
	    RESULT_VARIABLE cmd_result
            OUTPUT_VARIABLE id_value
            )

        if(cmd_result EQUAL 0)
            cmut_info("change ${item} id: ${id_value} ==>> ${rpath_filename}")
        else()
            cmut_error("change ${item} id failed")
        endif()

    endif()

endfunction()



function(cmut__utils__fixup_dylib_dependencies item install_dir)


    cmut__utils__find_program(install_name_tool REQUIRED)
    cmut__utils__find_program(otool REQUIRED)

    get_filename_component(item "${item}" REALPATH)
    if(NOT EXISTS "${item}")
        cmut_warning("file ${item} not found. Fixup dylib id skipped.")
        return()
    endif()

    execute_process(
        COMMAND "${OTOOL_CMD}" -L "${item}"
        OUTPUT_VARIABLE dependencies_value
        )


    # remove "file path:"
    string(REGEX REPLACE "[^\n]*:\n" "" dependencies_value "${dependencies_value}")

    # split end line
    string(REPLACE "\n" ";" dependencies_value ${dependencies_value})



    set(loop_index 0)
    foreach(dependency ${dependencies_value})

	math(EXPR loop_index "${loop_index} + 1")

        if(loop_index EQUAL 1)
            continue()
        endif()
  
        # remove (compatibility ...)
        string(REGEX REPLACE " *\\(compatibility.*\\)$" " " dependency ${dependency})

        # remove begin and end space
        string(STRIP ${dependency} dependency)

        if (NOT "${dependency}" MATCHES "^${install_dir}/.*$")
	    continue()
	endif()


        string(REPLACE "${install_dir}" "@rpath" rpath_filename ${dependency})


        if(NOT "rpath_filename" STREQUAL id_value)
    
            execute_process(
                COMMAND "${INSTALL_NAME_TOOL_CMD}" -change "${dependency}" "${rpath_filename}" "${item}"
	        RESULT_VARIABLE cmd_result
                OUTPUT_VARIABLE id_value
                )

            if(cmd_result EQUAL 0)
                cmut_info("change ${item} change: ${dependency} ==>> ${rpath_filename}")
            else()
                cmut_error("change ${item} change of ${dependency} failed")
            endif()
        endif()

    endforeach()

endfunction()


function(cmut__utils__install_name_tool output )

    cmut__utils__find_program(install_name_tool REQUIRED)
    
    foreach(arg ${ARGN})
        set(args "${args} \"${arg}\"")
    endforeach()

    execute_process(
        COMMAND "${INSTALL_NAME_TOOL_CMD}" ${args}
	RESULT_VARIABLE cmd_result
        OUTPUT_VARIABLE cmd_output
    )

    if(NOT cmd_result EQUAL 0)
        cmut_error("cmut__utils__install_name_tool : \"install_name_tool ${args}\" failed.")
    endif()
    
    set(${output} ${cmd_output} PARENT_SCOPE)

endfunction()


