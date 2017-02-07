include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()

cmake_policy(SET CMP0011 NEW)
cmake_policy(SET CMP0054 NEW)


include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmut__utils__parse_arguments.cmake)



function(cmut__utils__find_install_name_tool)

    cmut__utils__parse_arguments(find_install_name_tool "__" "REQUIRED" "" "")


    if(NOT APPLE)
        cmut_warning("install_name_tool available only on apple.")
	return()
    endif()

    find_program(INSTALL_NAME_TOOL_CMD "install_name_tool")
    mark_as_advanced(INSTALL_NAME_TOOL_CMD)

    if(__REQUIRED AND (NOT INSTALL_NAME_TOOL_CMD))
        cmut_error("install_name_tool not found.")
	return()
    endif()

endfunction()

function(cmut__utils__find_otool)

    cmut__utils__parse_arguments(find_otool "__" "REQUIRED" "" "")


    if(NOT APPLE)
        cmut_warning("otool available only on apple.")
	return()
    endif()

    find_program(OTOOL_CMD "otool")
    mark_as_advanced(OTOOL_CMD)

    if(__REQUIRED AND (NOT OTOOL_CMD))
        cmut_error("otool not found.")
	return()
    endif()

endfunction()



function(cmut__utils__fixup_dylib_id item)

    cmut__utils__find_install_name_tool(REQUIRED)
    cmut__utils__find_otool(REQUIRED)

    get_filename_component(item "${item}" REALPATH)
    if(NOT EXISTS "${item}")
        cmut_warning("file ${item} not found. Fixup dylib id skipped.")
        return()
    endif()

    execute_process(
        COMMAND "${OTOOL_CMD}" -D "${item}"
        OUTPUT_VARIABLE id_value
        )


    # remove <file path:>
    string(REPLACE "${item}:\n" "" id_value ${id_value})

    # remove end line
    string(REPLACE "\n" "" id_value ${id_value})

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

    cmut__utils__find_install_name_tool(REQUIRED)
    cmut__utils__find_otool(REQUIRED)

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
    string(REPLACE "${item}:\n" "" dependencies_value "${dependencies_value}")

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

        get_filename_component(filename ${dependency} NAME)
        get_filename_component(dirname ${dependency} DIRECTORY)


	if(NOT dirname STREQUAL install_dir)
	    continue()
	endif()

        set(rpath_filename "@rpath/${filename}")

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

