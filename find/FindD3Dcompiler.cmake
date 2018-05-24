
if(MSVC)
    get_filename_component(COMPILER_DIR "${CMAKE_CXX_COMPILER}" DIRECTORY)
    find_file(D3DCOMPILER d3dcompiler_47.dll
        HINT "${COMPILER_DIR}")

    if(NOT EXISTS "${D3DCOMPILER}")
        cmut_fatal("Can't find d3dcompiler_47.dll. Check your Visual Studio installation.")
    endif()
endif()
