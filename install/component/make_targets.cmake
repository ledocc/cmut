

function(cmut__install__component__make_targets)

    foreach(component IN LISTS ARGV)

        if( TARGET install_${component} )
            cmut__install__component__make_target__impl( ${component} )
        endif()

        cmut__install__component__get_dependencies( ${component} dependencies )
        if(dependencies)
            cmut__install__component__add_dependencies__impl(install_${component} ${dependencies})
        endif()

    endforeach()

endfunction()


function( cmut__install__component__make_target__impl component )

    add_custom_target(
        install_${component}
        COMMAND
            ${CMAKE_COMMAND}
            -DCMAKE_INSTALL_COMPONENT=${component}
            # use CMAKE_BINARY_DIR and not PROJECT_BINARY_DIR, always use the top level cmake_install.cmake script
            -P ${CMAKE_BINARY_DIR}/cmake_install.cmake
    )

endfunction()
