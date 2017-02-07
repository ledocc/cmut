
include(${CMAKE_CURRENT_LIST_DIR}/../util/parse_arguments.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake)


function(cmut__script__add_cmake_opt result)

    cmut__utils__parse_arguments__m(cmut__script__add_cmake_opt
        opt    
        "RESOLVE_PATH;DEFAULT_ENV"
        "NAME;DESC"
        "DEFAULT"
        ${ARGN}
        )

    if(NOT DEFINED ${opt_NAME} AND opt_DEFAULT)
        set(${opt_NAME} "${opt_DEFAULT}")
    endif()

    if(NOT DEFINED ${opt_NAME} AND opt_DEFAULT_ENV)
        set(from_env_var $ENV{${opt_NAME}})
        if(from_env_var)
            set(${opt_NAME} "${from_env_var}")
        endif()
    endif()
    
    if(NOT DEFINED ${opt_NAME})
        return()
    endif()

    
    if(opt_RESOLVE_PATH)
        get_filename_component(${opt_NAME} "${${opt_NAME}}" ABSOLUTE)
    endif()
    
    list(APPEND ${result} "-D${opt_NAME}=${${opt_NAME}}")
    cmut_info("${opt_DESC} : \"${${opt_NAME}}\"")

    set(${opt_NAME} "${${opt_NAME}}" PARENT_SCOPE)
    set(${result} "${${result}}" PARENT_SCOPE)
    
endfunction()
