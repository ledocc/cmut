
function(cmut__utils__canonical_path path_ base_ result)

    if(NOT IS_ABSOLUTE "${path_}")
        set(path_ "${base_}/${path_}")
    endif()

    set(${result} "${path_}" PARENT_SCOPE)

endfunction()
