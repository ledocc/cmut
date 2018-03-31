


function(cmut__test__qtest__get_required_components result)

    set(components
        Test
        )
    set(${result} "${components}" PARENT_SCOPE)

endfunction()


function(cmut__test__qtest__find_dependencies version)

    cmut__test__qtest__get_required_components(qtest_components)
    find_package(
        Qt5 ${version}
        REQUIRED COMPONENTS
            ${qtest_components}
        )

    if(NOT TARGET Qt5::Test)
        cmut_warn("[cmut][test][qtest] - Can't found Qt5::Test. Qt5 tests based skipped.")
        return()
    endif()


    foreach(component ${qtest_components})
        link_libraries( Qt5::${component} )
    endforeach()

endfunction()


function(cmut__test__qtest__add namespace test_name)

    cmut__utils__parse_arguments(
        cmut__test__qtest__add
        ARG
        ""
        ""
        "FILES;LIBRARIES"
    )

    cmut__test__make_test_name(${namespace} ${test_name} name)

    cmut__test__qtest__get_required_components(qtest_components)
    foreach(component ${qtest_components})
        if( NOT TARGET Qt5::${component} )
            cmut_info("[cmut][test][qtest] - ${name} skipped.")
        endif()
    endforeach()


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

    cmut__test__qtest__get_required_components(qtest_components)
    foreach(component ${qtest_components})
        link_libraries( Qt5::${component} )
    endforeach()


    add_test(NAME "${name}" COMMAND ${name})

endfunction()
