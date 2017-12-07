

function(cmut__utils__value_to_variable_name result value)

    # replace all characters other that "a-z A-Z 0-9 -" with '_'
    string( REGEX REPLACE "[^a-zA-Z0-9\-]" "_" variable_name "${value}" )

    # create safe name to create a file
    set( ${result} "${variable_name}" PARENT_SCOPE )

endfunction()
