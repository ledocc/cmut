
function(cmut__build__msvc__nominmax target)

    if(MSVC)
        target_compile_definitions(
            ${target}
            PUBLIC
                NOMINMAX
                )
    endif()

endfunction()
