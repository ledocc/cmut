

function(lg_set_cmake_property name)

    set_property(GLOBAL PROPERTY ${name} ${ARGN})

endfunction()
