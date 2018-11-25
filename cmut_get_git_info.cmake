
function(cmut_get_git_revision_count revisionCount)

    cmut_deprecated_function(cmut_get_git_revision_count cmut__project__get_git_revision_count)
    cmut__project__get_git_revision_count(result)
    set(${revisionCount} ${result} PARENT_SCOPE)

endfunction()




function(cmut_get_git_revision_hash revisionHash)

    cmut_deprecated_function(cmut_get_git_revision_hash cmut__project__get_git_revision_hash)
    cmut__project__get_git_revision_hash(result)
    set(${revisionHash} ${result} PARENT_SCOPE)

endfunction()
