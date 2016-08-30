
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
