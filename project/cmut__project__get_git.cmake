

function(cmut__project__get_git_revision_count result )
    set(CMAKE_CURRENT_FUNCTION cmut__project__get_git_revision_count)

    cmut__lang__function__add_param( GIT_ROOT_DIR DEFAULT "${PROJECT_SOURCE_DIR}" )
    cmut__lang__function__parse_arguments( ${ARGN} )

    if ( NOT EXISTS "${ARG_GIT_ROOT_DIR}/.git" )
        cmut__lang__return_unset()
        return()
    endif()

    cmut__git__get_revision_count( revision_count GIT_DIR "${ARG_GIT_ROOT_DIR}" )
    cmut__lang__return( revision_count )

endfunction()

function(cmut__project__get_git_revision_hash result)
    set(CMAKE_CURRENT_FUNCTION cmut__project__get_git_revision_hash)

    cmut__lang__function__add_param( GIT_ROOT_DIR DEFAULT "${PROJECT_SOURCE_DIR}" )
    cmut__lang__function__parse_arguments( ${ARGN} )

    if ( NOT EXISTS "${ARG_GIT_ROOT_DIR}/.git" )
        cmut__lang__return_unset()
        return()
    endif()

    cmut__git__get_revision_hash( revision_hash GIT_DIR "${ARG_GIT_ROOT_DIR}" )
    cmut__lang__return( revision_hash )

endfunction()
