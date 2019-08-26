
function( cmut__target__get_generated_header_output_directory result target )

    get_target_property( output_dir ${target} BINARY_DIR )
    cmut__lang__return_value( "${output_dir}/cmut__target__generated/include" )

endfunction()
