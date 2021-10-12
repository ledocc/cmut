set(_find_std_filesystem_src ${CMAKE_CURRENT_LIST_DIR}/FindStdFilesystem.cpp)

function(try_compile_std_filesystem result library)

    set(compile_arg CXX_STANDARD 17)
    if(library)
        list(
            APPEND
            compile_arg
            LINK_LIBRARIES
            ${library}
        )
    endif()
    try_compile(compile_result ${CMAKE_CURRENT_BINARY_DIR} ${_find_std_filesystem_src} ${compile_arg})

    set(${result}
        ${compile_result}
        PARENT_SCOPE
    )
endfunction()

foreach(library "" "stdc++fs" "c++fs")
    try_compile_std_filesystem(compiled "${library}")
    if(compiled)
        set(StdFilesystem_LIBRARY ${library})
        break()
    endif()
endforeach()

if(StdFilesystem_LIBRARY)
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(
        StdFilesystem
        FOUND_VAR StdFilesystem_FOUND
        REQUIRED_VARS StdFilesystem_LIBRARY
    )
else()
    set(StdFilesystem_FOUND TRUE)
endif()

mark_as_advanced(StdFilesystem_LIBRARY)

if(StdFilesystem_FOUND AND NOT (TARGET std::filesystem))
    add_library(std::filesystem INTERFACE IMPORTED)
    if(StdFilesystem_LIBRARY)
        set_target_properties(std::filesystem PROPERTIES INTERFACE_LINK_LIBRARIES ${StdFilesystem_LIBRARY})
    endif()
endif()
