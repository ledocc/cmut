

function(cmut__qt5__get_qmake_property result property_name)

    if(NOT QT5_QMAKE_COMMAND)
        find_file(QT5_QMAKE_COMMAND qmake)

        if(NOT QT5_QMAKE_COMMAND)
            cmut_fatal("Can't find qmake, check if it is installed.")
        endif()
    endif()


    execute_process(
        COMMAND ${QT5_QMAKE_COMMAND} "-query" "QT_${property_name}"
        OUTPUT_VARIABLE property_value
        OUTPUT_STRIP_TRAILING_WHITESPACE
        )
    cmut_debug("[cmut][qt5][get_qmake_property] - ${property_name} : ${property_value}")


    set(${result} "${property_value}" PARENT_SCOPE)


endfunction()
