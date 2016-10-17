include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()


function(cmut__target__generate_export_header target)

    if(ARGC GREATER 0)
        set(export_filename "include/${ARGV1}")
    else()
        string(TOLOWER "${target}" target_lower)
        set(export_filename "include/${target_lower}_export.h")
    endif()

    include(GenerateExportHeader)
    generate_export_header(${target}
        EXPORT_FILE_NAME "${CMAKE_CURRENT_BINARY_DIR}/${export_filename}")

    set_target_properties(${target} PROPERTIES CMUT__TARGET__EXPORT_HEADER "${export_filename}")


    target_sources(
        ${target}
        PUBLIC
            "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/${export_filename}>"
    )

    target_include_directories(
        ${target}
        PUBLIC
            "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>"
    )


endfunction()
