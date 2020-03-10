

function(cmut__project__get_git_revision_count result )
    set(CMAKE_CURRENT_FUNCTION cmut__project__get_git_revision_count)


    if ( NOT EXISTS "${PROJECT_SOURCE_DIR}/.git" )
        cmut__lang__return_unset()
        return()
    endif()

    cmut__git__get_revision_count( revision_count GIT_DIR "${PROJECT_SOURCE_DIR}" )
    cmut__lang__return( revision_count )

endfunction()

function(cmut__project__get_git_revision_hash result)

    if ( NOT EXISTS "${PROJECT_SOURCE_DIR}/.git" )
        cmut__lang__return_unset()
        return()
    endif()

    cmut__git__get_revision_hash( revision_hash GIT_DIR "${PROJECT_SOURCE_DIR}" )
    cmut__lang__return( revision_hash )

endfunction()
