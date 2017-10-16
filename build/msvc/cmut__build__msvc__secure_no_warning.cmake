include(${CMAKE_CURRENT_LIST_DIR}/../../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



function(cmut__build__msvc__secure_no_warning target)

    if(NOT MSVC)
        return()
    endif()

    set(scope PUBLIC)

    get_target_property(type ${target} TYPE)
    if(type STREQUAL "INTERFACE_LIBRARY")
        set(scope INTERFACE)
    endif()


    target_compile_definitions(
        ${target}
        ${scope}
            _SCL_SECURE_NO_WARNINGS
            _CRT_SECURE_NO_WARNINGS
            )

endfunction()
