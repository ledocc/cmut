

function(cmut__test__boost__get_required_components result)

    set( components
         chrono
         timer
         unit_test_framework
    )

    set( ${result} "${components}" PARENT_SCOPE )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__cmut__test__boost__get_main_component result)

    set( ${result} unit_test_framework PARENT_SCOPE )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(cmut__test__boost__find_required_components version)

    cmut__test__boost__get_required_components( components )
    find_package(
        Boost ${version}
        REQUIRED COMPONENTS
            ${components}
        )

    if( MSVC )
        cmut__target__append_property(Boost::unit_test_framework INTERFACE_COMPILE_OPTIONS -wd4389 )
    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function( cmut__test__boost__link_target target )

    cmut__test__boost__get_required_components( components )

    foreach( component IN LISTS components )
        target_link_libraries( ${target} PUBLIC Boost::${component} )
    endforeach()


    __cmut__test__boost__get_main_component( main_component )

    get_target_property( BUILD_TYPE Boost::${main_component} TYPE )
    if( NOT ${BUILD_TYPE} STREQUAL STATIC_LIBRARY )
        target_compile_definitions( ${target} PUBLIC BOOST_TEST_DYN_LINK )
    endif()
    target_compile_definitions( ${target} PUBLIC BOOST_ALL_NO_LIB )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function( cmut__test__boost__add_test namespace test_src_file )

    cmut__test__make_test_name( ${namespace} ${test_src_file} name )

    add_executable( ${name} ${test_src_file} ${ARGN} )
    cmut__test__boost__link_target( ${name} )
    add_test( NAME "${name}" COMMAND ${name} )


#    file(READ "${test_src_file}" _contents)
#    string(REGEX MATCHALL "BOOST_[A-Z]+_TEST_CASE\\([:*, A-Za-z_0-9]+\\)"
#        _test_instances ${_contents})

#    foreach(_test ${_test_instances})

#        string(REGEX REPLACE ".*\\( *([A-Za-z_0-9]+).*\\).*" "\\1" test_name ${_test})

#        add_test(NAME "${_test_exec_name}.${test_name}"
#            COMMAND ${_test_exec_name}
#            --run_test=${test_name} --catch_system_error=yes)
#    endforeach()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function( cmut__test__boost__add_tests namespace )

    foreach(file ${ARGN})
        cmut__test__boost__add_test(${namespace} ${file} "")
    endforeach()

endfunction()
