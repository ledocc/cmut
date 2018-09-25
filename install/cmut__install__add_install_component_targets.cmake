include("${CMAKE_CURRENT_LIST_DIR}/cmut__install__component_dependency.cmake")



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


        cmut__install__get_component_dependency(${component} dependencies)
        list(LENGTH dependencies dependenciesSize)

        if(dependenciesSize)
            cmut__install__add_component_dependencies__impl(install_${component} ${dependencies})
        endif()


    endforeach()

endfunction()
