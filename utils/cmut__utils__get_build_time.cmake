


function(cmut__utils__get_build_time result)

    cmut_deprecated_function(cmut__utils__get_build_time cmut__project__get_build_time)
    cmut__project__get_build_time( result_ )
    set( ${result} ${result_} PARENT_SCOPE )

endfunction()
