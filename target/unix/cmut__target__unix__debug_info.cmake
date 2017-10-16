include("${CMAKE_CURRENT_LIST_DIR}/../../utils/cmut__utils__parse_arguments.cmake")




function(__cmut__target__unix__get_copy_debug_info_command target output_file result)

    set(${result}
        ${OBJCOPY_COMMAND} --only-keep-debug $<TARGET_FILE:${target}> ${output_file}
        PARENT_SCOPE
        )

endfunction()

function(__cmut__target__unix__get_strip_debug_info_command target result)

    set(${result}
        ${OBJCOPY_COMMAND} --strip-debug $<TARGET_FILE:${target}>
        PARENT_SCOPE
        )

endfunction()





function(cmut__target__unix__copy_debug_info target output_file)

    cmut__utils__parse_arguments(cmut__target__unix__copy_debug_info
        "ARG"
        "NO_DEPENDS_TARGET"
        ""
        ""
        ${ARGN}
        )

    if(NOT ARG_NO_DEPENDS_TARGET)
        set(depends_arg DEPENDS ${target})
    endif()

    find_program(OBJCOPY_COMMAND objcopy)

    __cmut__target__unix__get_copy_debug_info_command(${target} ${output_file} copy_debug_info_command)

    add_custom_target(copy_${target}_debug_info ${copy_debug_info_command}
        COMMENT "copy debug info from \"${target}\" to ${output_file}"
        ${depends_arg}
    )

endfunction()

function(cmut__target__unix__strip_debug_info target)

    cmut__utils__parse_arguments(cmut__target__unix__copy_debug_info
        "ARG"
        "NO_DEPENDS_TARGET"
        ""
        ""
        ${ARGN}
        )

    if(NOT ARG_NO_DEPENDS_TARGET)
        set(depends_arg DEPENDS ${target})
    endif()


    find_program(OBJCOPY_COMMAND objcopy)

    __cmut__target__unix__get_strip_debug_info_command(${target} strip_debug_info_command)

    add_custom_target(strip_${target}_debug_info ${strip_debug_info_command}
        COMMENT "strip debug info from \"${target}\""
        ${depends_arg}
    )

endfunction()

function(cmut__target__unix__copy_and_strip_debug_info target output_file)

    cmut__utils__parse_arguments(cmut__target__unix__copy_debug_info
        "ARG"
        "NO_DEPENDS_TARGET"
        ""
        ""
        ${ARGN}
        )

    if(NOT ARG_NO_DEPENDS_TARGET)
        set(depends_arg DEPENDS ${target})
    endif()


    find_program(OBJCOPY_COMMAND objcopy)

    __cmut__target__unix__get_copy_debug_info_command(${target} ${output_file} copy_debug_info_command)
    __cmut__target__unix__get_strip_debug_info_command(${target} strip_debug_info_command)

    add_custom_target(copy_and_strip_${target}_debug_info
        COMMAND ${copy_debug_info_command}
        COMMAND ${strip_debug_info_command}
        COMMENT "copy debug info from \"${target}\" to ${output_file}, then strip debug info from \"${target}\""
        ${depends_arg}
    )

endfunction()
