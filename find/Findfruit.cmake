# You can set your own route by setting FRUIT_INSTALLED_DIR:
# set(ENV{FRUIT_INSTALLED_DIR} "/path/to/fruit/build")

find_path(FRUIT_INCLUDE_DIR fruit/fruit.h
    HINTS
        ${FRUIT_INSTALLED_DIR}
    PATH_SUFFIXES include
    )

find_library(FRUIT_LIBRARY
    NAMES fruit
    HINTS 
        ${FRUIT_INSTALLED_DIR}
    PATH_SUFFIXES lib lib64
    )

include(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)
find_package_handle_standard_args(Fruit DEFAULT_MSG FRUIT_LIBRARY FRUIT_INCLUDE_DIR)

if(NOT TARGET fruit::fruit)
    add_library(fruit::fruit UNKNOWN IMPORTED)
    set_target_properties(fruit::fruit PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${FRUIT_INCLUDE_DIRS}")

    if(FRUIT_LIBRARY_RELEASE)
        set_property(TARGET fruit::fruit APPEND PROPERTY
            IMPORTED_CONFIGURATIONS RELEASE)
        set_target_properties(fruit::fruit PROPERTIES
            IMPORTED_LOCATION_RELEASE "${FRUIT_LIBRARY_RELEASE}")
    endif()

    if(FRUIT_LIBRARY_DEBUG)
        set_property(TARGET fruit::fruit APPEND PROPERTY
            IMPORTED_CONFIGURATIONS DEBUG)
        set_target_properties(fruit::fruit PROPERTIES
            IMPORTED_LOCATION_DEBUG "${FRUIT_LIBRARY_DEBUG}")
    endif()

    if(NOT FRUIT_LIBRARY_RELEASE AND NOT FRUIT_LIBRARY_DEBUG)
        set_property(TARGET fruit::fruit APPEND PROPERTY
            IMPORTED_LOCATION "${FRUIT_LIBRARY}")
    endif()
endif()

