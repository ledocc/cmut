

function(__cmut_print_find_library_type_order_begin TYPE ORDER)
    message(STATUS "cmut change find_library order : search ${TYPE} ${ORDER}")
    message(STATUS "    original CMAKE_FIND_LIBRARY_SUFFIXES = ${CMAKE_FIND_LIBRARY_SUFFIXES}")
endfunction()

function(__cmut_print_find_library_type_order_end)
    message(STATUS "    current  CMAKE_FIND_LIBRARY_SUFFIXES = ${CMAKE_FIND_LIBRARY_SUFFIXES}")
endfunction()


macro(cmut_find_static_library_first)

    __cmut_print_find_library_type_order_begin(static first)

    set(CMAKE_FIND_LIBRARY_SUFFIXES)
    list(APPEND CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_STATIC_LIBRARY_SUFFIX})
    list(APPEND CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_SHARED_LIBRARY_SUFFIX})

    __cmut_print_find_library_type_order_end()

endmacro()


macro(cmut_find_static_library_only)

    __cmut_print_find_library_type_order_begin(static only)

    set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_STATIC_LIBRARY_SUFFIX})

    __cmut_print_find_library_type_order_end()

endmacro()


macro(cmut_find_shared_library_first)

    __cmut_print_find_library_type_order_begin(shared first)

    set(CMAKE_FIND_LIBRARY_SUFFIXES)
    list(APPEND CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_SHARED_LIBRARY_SUFFIX})
    list(APPEND CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_STATIC_LIBRARY_SUFFIX})

    __cmut_print_find_library_type_order_end()

endmacro()


macro(cmut_find_shared_library_only)

    __cmut_print_find_library_type_order_begin(shared only)

    set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_SHARED_LIBRARY_SUFFIX})

    __cmut_print_find_library_type_order_end()

endmacro()
