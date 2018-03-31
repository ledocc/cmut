
function(cmut__test__make_test_name namespace test_src_file result)

    get_filename_component(_test_exec_name ${test_src_file} NAME_WE)
    get_filename_component(_path ${test_src_file} DIRECTORY)

    while(_path)

        get_filename_component(_dirname ${_path} NAME_WE)
        set(_test_exec_name "${_dirname}_${_test_exec_name}")
        get_filename_component(_path ${_path} DIRECTORY)

    endwhile()

    set(${result} ${namespace}__${_test_exec_name} PARENT_SCOPE)

endfunction()
