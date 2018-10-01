
function(cmut_get_git_revision_count revisionCount)

    execute_process(
        COMMAND git rev-list --count HEAD
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        RESULT_VARIABLE result
        OUTPUT_VARIABLE output
        ERROR_VARIABLE error
	OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(error)
        message(SEND_ERROR "cmut : Can't retrieve revision count from local git repository.")
    endif()

    set(${revisionCount} ${output} PARENT_SCOPE)

endfunction()




function(cmut_get_git_revision_hash revisionHash)

    execute_process(
        COMMAND git rev-list --max-count 1 --abbrev-commit HEAD
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        RESULT_VARIABLE result
        OUTPUT_VARIABLE output
        ERROR_VARIABLE error
	OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(error)
        message(SEND_ERROR "cmut : Can't retrieve hash from local git repository.")
    endif()

    set(${revisionHash} ${output} PARENT_SCOPE)

endfunction()
