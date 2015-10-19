


function(cmut_qmake_query VAR PROP ) #QMAKE_PATH)

#    if(NOT QMAKE_PATH)
        set(QMAKE_PATH qmake)
#    endif()
    execute_process(COMMAND ${QMAKE_PATH} -query ${PROP}
                    OUTPUT_VARIABLE PROP_VALUE
                    OUTPUT_STRIP_TRAILING_WHITESPACE) 

    set(${VAR} ${PROP_VALUE} PARENT_SCOPE)
endfunction()