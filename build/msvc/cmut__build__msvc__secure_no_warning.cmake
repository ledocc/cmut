include(${CMAKE_CURRENT_LIST_DIR}/../../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



function(cmut__build__msvc__secure_no_warning target)

    if(MSVC)
        target_compile_definitions(
            ${target}
            PUBLIC
                _SCL_SECURE_NO_WARNINGS
                _CRT_SECURE_NO_WARNINGS
                )
    endif()

endfunction()
