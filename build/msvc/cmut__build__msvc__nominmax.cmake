include(${CMAKE_CURRENT_LIST_DIR}/../../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



function(cmut__build__msvc__nominmax target)

    if(MSVC)
        target_compile_definitions(
            ${target}
            PUBLIC
                NOMINMAX
                )
    endif()

endfunction()
