
function(get_git_revision_count revisionCount)

    execute_process(
        COMMAND git rev-list --count HEAD
        WORKING_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}
        RESULT_VARIABLE result
        OUTPUT_VARIABLE output
        ERROR_VARIABLE error
    )

    if(error)
        message(SEND_ERROR "Can't retrive revision count from local git repository. Abort")
    endif()

    set(${revisionCount} ${output} PARENT_SCOPE)

endfunction()




function(get_git_revision_hash revisionHash)

    execute_process(
        COMMAND git rev-list --max-count 1 --abbrev-commit HEAD
        WORKING_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}
        RESULT_VARIABLE result
        OUTPUT_VARIABLE output
        ERROR_VARIABLE error
    )

    if(error)
        message(SEND_ERROR "Can't retrive hash from local git repository. Abort")
    endif()

    set(${revisionHash} ${output} PARENT_SCOPE)

endfunction()

