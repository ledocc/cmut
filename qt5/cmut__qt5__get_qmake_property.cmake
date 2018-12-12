



function(cmut__qt5__find_qmake)

    if(QT_QMAKE_EXECUTABLE)
        return()
    endif()

    if(NOT QT_QMAKE_EXECUTABLE)
        find_program(QT_QMAKE_EXECUTABLE qmake)
    endif()

    if(NOT QT_QMAKE_EXECUTABLE)
        cmut_fatal("Can't find qmake, check if it is installed.")
    endif()

endfunction()

########################################################################################################################
########################################################################################################################
########################################################################################################################

function(cmut__qt5__get_qmake_property result property_name)

    cmut__qt5__find_qmake()


    execute_process(
        COMMAND ${QT_QMAKE_EXECUTABLE} "-query" "QT_${property_name}"
        OUTPUT_VARIABLE property_value
        OUTPUT_STRIP_TRAILING_WHITESPACE
        )
    cmut_debug("[cmut][qt5][get_qmake_property] - ${property_name} : ${property_value}")

    set(${result} "${property_value}" PARENT_SCOPE)

endfunction()
