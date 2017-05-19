

function(cmut__install__add_install_component_targets)

    if(NOT ARGC)
        return()
    endif()


    foreach(component IN LISTS ARGV)

        if(NOT TARGET install_${component})
            add_custom_target(
                install_${component}
                COMMAND
                    ${CMAKE_COMMAND}
                        -DCMAKE_INSTALL_COMPONENT=${component}
                        # use CMAKE_BINARY_DIR and not PROJECT_BINARY_DIR, always use the top level cmake_install.cmake script
                        -P ${CMAKE_BINARY_DIR}/cmake_install.cmake
                )
        endif()

    endforeach()

endfunction()
