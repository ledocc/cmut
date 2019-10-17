

function(cmut__project__get_git_revision_count revisionCount )

    find_package(Git REQUIRED)

    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-list --count HEAD
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        RESULT_VARIABLE result
        OUTPUT_VARIABLE output
        ERROR_VARIABLE error
	OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(error)
        cmut__log__error( cmut__project__get_git_revision_count "Can't retrieve revision count from local git repository." )
    endif()

    set(${revisionCount} ${output} PARENT_SCOPE)

endfunction()




function(cmut__project__get_git_revision_hash revisionHash)

    find_package(Git REQUIRED)

    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-list --max-count 1 --abbrev-commit HEAD
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        RESULT_VARIABLE result
        OUTPUT_VARIABLE output
        ERROR_VARIABLE error
	OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(error)
        cmut__log__error( cmut__project__get_git_revision_hash "Can't retrieve hash from local git repository." )
    endif()

    set(${revisionHash} ${output} PARENT_SCOPE)

endfunction()
