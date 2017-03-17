

function(cmut__utils__increment value result)

    math(EXPR __result "${value} + 1")
    set(${result} ${__result})

endfunction()
