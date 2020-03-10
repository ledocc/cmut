include("${CMAKE_CURRENT_LIST_DIR}/init.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../log.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../lang.cmake")



function(cmut__git__get_revision_hash result)

    cmut__lang__function__init_param(cmut__git__get_revision_hash)
    cmut__lang__function__add_param(GIT_DIR DEFAULT "${PROJECT_SOURCE_DIR}")
    cmut__lang__function__parse_arguments($ARGN)


    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-list --max-count 1 --abbrev-commit HEAD
        WORKING_DIRECTORY "${ARG_GIT_DIR}"
        RESULT_VARIABLE cmd_result
        OUTPUT_VARIABLE cmd_output
        ERROR_VARIABLE cmd_error
	      OUTPUT_STRIP_TRAILING_WHITESPACE
        )

    if(cmd_error)
        cmut__log__error( ${CMAKE_CURRENT_FUNCTION} "Can't retrieve hash from local git repository.\nerror : ${cmd_error}" )
    endif()

    cmut__lang__return(cmd_output)

endfunction()
