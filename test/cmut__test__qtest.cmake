


function( cmut__test__qtest__get_required_components result )

    set( components
         Test
    )
    set( ${result} "${components}" PARENT_SCOPE )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function( cmut__test__qtest__find_required_components version )

    cmut__test__qtest__get_required_components( qtest_components )
    find_package(
        Qt5 ${version}
        REQUIRED COMPONENTS
            ${qtest_components}
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(cmut__test__qtest__link_target target)

    cmut__test__qtest__get_required_components( components )

    foreach( component IN LISTS components )
        target_link_libraries( ${target} PUBLIC Qt5::${component} )
    endforeach()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function( cmut__test__qtest__add namespace test_name )

    cmut__utils__parse_arguments(
        cmut__test__qtest__add
        ARG
        ""
        ""
        "FILES;LIBRARIES"
    )

    cmut__test__make_test_name( ${namespace} ${test_name} name )


    if("${ARG_FILES}" STREQUAL "")
        set(ARG_FILES ${test_name}.test.cpp)
    endif()

    add_executable(${name} ${ARG_FILES})

    foreach(file IN LISTS ARG_FILES)

        get_filename_component(filename "${file}" NAME)
        QT5_GENERATE_MOC("${file}" "${CMAKE_CURRENT_BINARY_DIR}/${filename}.moc")
        target_sources(${name} PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/${filename}.moc")

    endforeach()

    target_include_directories(${name} PUBLIC "${CMAKE_CURRENT_BINARY_DIR}")


    if(NOT "${ARG_LIBRARIES}" STREQUAL "")
        target_link_libraries(${name} "${ARG_LIBRARIES}")
    endif()

    cmut__test__qtest__link_target( ${name} )

    add_test(NAME "${name}" COMMAND ${name})

endfunction()
