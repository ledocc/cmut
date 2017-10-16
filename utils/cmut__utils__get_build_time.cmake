


function(cmut__utils__get_build_time result)

    string(TIMESTAMP time "%Y-%m-%d %H:%M:%S UTC" UTC)
    set(${result} ${time} PARENT_SCOPE)

endfunction()
