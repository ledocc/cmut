

function(cmut__utils__set_if_defined result_ condition_ true_ false_)

    set(__result ${false_})
    if(DEFINED ${condition_})
        set(__result ${true_})
    endif()

    set(${result_} ${__result} PARENT_SCOPE)

endfunction()
