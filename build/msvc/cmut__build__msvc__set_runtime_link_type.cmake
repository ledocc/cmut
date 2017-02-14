include(${CMAKE_CURRENT_LIST_DIR}/../../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



function(cmut__build__msvc__set_runtime_link_type link_type)

    if(NOT MSVC)
        return()
    endif()

    if("${link_type}" STREQUAL "STATIC")
        set(runtime_link_type_option /MT)
    elseif(${link_type} STREQUAL "DYNAMIC")
        set(runtime_link_type_option /MD)
    else()
        cmut_error("cmut__build__msvc__set_runtime_link_type : \"${link_type}\" not a valid runtime link type")
    endif()
    

    if(NOT CMAKE_BUILD_TYPE)
        set(__BUILD_TYPE "Release")
    else()
        set(__BUILD_TYPE ${CMAKE_BUILD_TYPE})
    endif()

    if ("${__BUILD_TYPE}" STREQUAL "Debug")
        set(runtime_link_type_option ${runtime_link_type_option}d)
    endif()
    
#    target_compile_options(${target} PUBLIC "${runtime_link_type_option}")
    
    
    if(DEFINED CMAKE_BUILD_TYPE)
        string(TOUPPER  ${CMAKE_BUILD_TYPE} UPPER_CASE)
        set(VARIABLE_SUFFIX _${UPPER_CASE})
    endif()
    
    set(VARIABLE_NAME CMAKE_CXX_FLAGS${VARIABLE_SUFFIX})
    
    string(REGEX REPLACE "/M[DT]d?" "${runtime_link_type_option}" ${VARIABLE_NAME} "${${VARIABLE_NAME}}")
    set(${VARIABLE_NAME} "${${VARIABLE_NAME}}" PARENT_SCOPE)
endfunction()
