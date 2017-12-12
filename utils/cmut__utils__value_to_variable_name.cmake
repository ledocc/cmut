
function(cmut__utils__value_to_variable_name result value)
    # get the filename
    get_filename_component(SOURCE_FILE_NAME "${value}" NAME)
    # replace all special characters with '_'
    string(REGEX REPLACE "[^a-zA-Z0-9\-]" "_" SOURCE_FILE_NAME_VARIABLE "${SOURCE_FILE_NAME}")
    # create safe name to create a file
    set(${result} "${SOURCE_FILE_NAME_VARIABLE}" PARENT_SCOPE)
endfunction()

