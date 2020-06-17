
macro( cmut__dependency__build_with_conan )

    cmut__lang__function__init_param(cmut__dependency__build_with_conan)
    cmut__lang__function__add_param(CONAN_VERSION DEFAULT 1.25.2)
    cmut__lang__function__add_param(CMAKE_CONAN_VERSION)
    cmut__lang__function__parse_arguments(${ARGN})


    option(BUILD_DEPENDENCIES "use conan to install dependencies." OFF)

    if( BUILD_DEPENDENCIES )
        cmut__conan__build()
    endif()

    if( CONAN_EXPORTED )
        include( "${PROJECT_BINARY_DIR}/conanbuildinfo.cmake" )
        conan_basic_setup(TARGETS NO_OUTPUT_DIRS)
    endif()

    if( BUILD_DEPENDENCIES OR CONAN_EXPORTED )
        include( "${PROJECT_BINARY_DIR}/conan_paths.cmake" )
    endif()

endmacro()
