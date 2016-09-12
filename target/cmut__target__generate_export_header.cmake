include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()


function(cmut__target__generate_export_header target)


    include(GenerateExportHeader)
    generate_export_header(${target})

    string(TOLOWER ${target} target_lower)
    
    target_sources(
        ${target}
        PUBLIC
            "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/${target_lower}_export.h>"
    )

    target_include_directories(
        ${target}
        PUBLIC
            "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>"
    )

    
endfunction()
