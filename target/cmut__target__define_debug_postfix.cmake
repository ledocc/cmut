

function(cmut__target__define_debug_postfix target debug_postfix)

    set_target_properties(${target} PROPERTIES DEBUG_POSTFIX "d")

endfunction()
