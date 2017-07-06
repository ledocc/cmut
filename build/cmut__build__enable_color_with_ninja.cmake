



function(cmut__build__enable_color_with_ninja)

    if (     (CMAKE_GENERATOR STREQUAL "Ninja")
         AND (    (CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.9)
               OR (CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 3.5)
             )
       )

        # Force colored warnings in Ninja's output, if the compiler has -fdiagnostics-color support.
        # Rationale in https://github.com/ninja-build/ninja/issues/814
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fdiagnostics-color=always" PARENT_SCOPE)

    endif()

endfunction()
