if(NOT DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)
set(${CMAKE_CURRENT_LIST_FILE}_include "1")
    

cmake_policy(VERSION 3.5.2)

include(CMakePrintHelpers)
include(cmut_message)


set(__CMUT_EP_TO_BUILD_PREFIX CMUT_EP_)

macro(__cmut_EP_add_module_to_build_list name)
    list(APPEND __CMUT_EP_MODULE_TO_BUILD ${name}) 
endmacro()
    
macro(cmut_EP_add_optional_module name)
    option(${__CMUT_EP_TO_BUILD_PREFIX}${name} OFF "Enable build of ${name}")
    __cmut_EP_add_module_to_build_list(${name})
endmacro()

macro(cmut_EP_add_module name)
    set(${__CMUT_EP_TO_BUILD_PREFIX}${name} ON)
    __cmut_EP_add_module_to_build_list(${name})
endmacro()



function(cmut_EP_define_dependencies name)
    cmut_debug("cmut_EP_define_dependencies(${name}) -- begin")

    set(__depends)
    foreach(dependency ${ARGN})
        list(APPEND __depends ${dependency})
    endforeach()

    __cmut_EP_is_dependencies_defined(${name} is_dependencies_defined)
    if(NOT is_dependencies_defined)
        define_property(GLOBAL
            PROPERTY CMUT_EP_${name}_DEPENDS
            BRIEF_DOCS "${name} dependency list"
            FULL_DOCS  "list of module that ${name} depend")
    endif()
    set_property(GLOBAL PROPERTY CMUT_EP_${name}_DEPENDENCIES ${__depends})
    
    cmut_debug("cmut_EP_define_dependencies : result = ${__depends}")
    cmut_debug("cmut_EP_define_dependencies(${name}) -- end")
endfunction()

function(__cmut_EP_is_dependencies_defined name result)
    get_property(__result GLOBAL PROPERTY CMUT_EP_${name}_DEPENDENCIES SET)
    set(${result} ${__result} PARENT_SCOPE)
endfunction()    

function(cmut_EP_make_depends name)

    cmut_debug("cmut_EP_make_depends(${name}) -- begin")

    __cmut_EP_is_dependencies_defined(${name} has_dependencies)
    if(NOT has_dependencies)
        cmut_debug("cmut_EP_make_depends : no dependencies defined for ${name}")
        cmut_debug("cmut_EP_make_depends(${name}) -- end")
        return()
    endif()

    get_property(dependencies GLOBAL PROPERTY CMUT_EP_${name}_DEPENDENCIES)


    foreach(dependency ${dependencies})
        if(DEFINED ${__CMUT_EP_TO_BUILD_PREFIX}${dependency})
            if(${__CMUT_EP_TO_BUILD_PREFIX}${dependency})
                cmut_debug("cmut_EP_make_depends : add dependency \"${dependency}\"")
                list(APPEND __depends ${dependency})
            else()
                cmut_debug("cmut_EP_make_depends : dependency \"${dependency}\" disable. skip.")
            endif()
        else()
            cmut_debug("cmut_EP_make_depends : dependency \"${dependency}\" not defined")
        endif()
    endforeach()

    
    set(CMUT_EP_${name}_DEPENDS ${__depends} PARENT_SCOPE)

    cmut_debug("cmut_EP_make_depends(${name}) -- end")

endfunction()


macro(__cmut_EP_include_module_dependencies name)

    set(__dependencies_file ${CMAKE_SOURCE_DIR}/${CMUT_MODULE_PREFIX}/${name}/dependencies.cmake)
    
    if (EXISTS ${__dependencies_file})
        cmut_debug("${name} dependencies file : ${__dependencies_file} found")
        cmut_info("include ${name} dependencies file")
        include(${__dependencies_file})
    else()
        cmut_debug("${name} dependencies file \"${__dependencies_file}\" not found")
    endif()

endmacro()



macro(__cmut_EP_build_module name)  

    cmut_debug("__cmut_EP_build_module(${name})")
    
    # check loop dependency
    if(${name} IN_LIST __cmut_EP_build_module_stack)
        cmut_info("__cmut_EP_build_module : loop dependency detected.\n"
                  "stack : ")
        foreach(module ${__cmut_EP_build_module_stack})
            cmut_info(${module})
        endforeach()
        message(FATAL_ERROR "loop dependency detected !!! ")
    endif()    

    
    # if already done, return
    if(NOT ${name} IN_LIST __cmut_EP_build_module_done_list)
    
        # add to build_stack
        list(APPEND __cmut_EP_build_module_stack ${name})
        cmut_debug("__cmut_EP_build_module : build_module_stack ${__cmut_EP_build_module_stack}")
        
        if(${__CMUT_EP_TO_BUILD_PREFIX}${module})

            # load and add dependencies
            __cmut_EP_include_module_dependencies(${name})
            __cmut_EP_build_module_dependencies(${name})

            # add module
            cmut_info("add module \"${name}\"")
            add_subdirectory(${CMUT_MODULE_PREFIX}/${name})

            # mark as done
            list(APPEND __cmut_EP_build_module_done_list ${name})
            cmut_debug("__cmut_EP_build_module : build_module_done_list ${__cmut_EP_build_module_done_list}")
        else()
            cmut_info("__cmut_EP_build_module : module ${name} not added (disable).")
        endif()
    
        # remove from build_stack
        list(REMOVE_ITEM __cmut_EP_build_module_stack ${name})
        cmut_debug("__cmut_EP_build_module : build_module_stack ${__cmut_EP_build_module_stack}")
    endif()

    cmut_debug("__cmut_EP_build_module(${name}) done")

endmacro()


macro(__cmut_EP_build_module_dependencies name)
    cmut_EP_make_depends(${name})
    foreach(module ${CMUT_EP_${name}_DEPENDS})
        __cmut_EP_build_module(${module})
    endforeach() 
endmacro()


function(cmut_EP_run)
    foreach(module ${__CMUT_EP_MODULE_TO_BUILD})
        __cmut_EP_build_module(${module})
    endforeach()
endfunction()


macro(cmut_define_EP_version name version)
    set(CMUT_EP_${name}_VERSION ${version} CACHE STRING "${name} version to build")
endmacro()





macro(cmut_EP_add_variable_if_defined __list __variable)
    if(${__variable})
        list(APPEND ${__list} "-D${__variable}=${${__variable}}")
    endif()
endmacro()

function(cmut_EP_collect_cmake_variable resultVariable)

    set(__cmake_vars)

    cmut_EP_add_variable_if_defined(__cmake_vars BUILD_SHARED_LIBS)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_INSTALL_PREFIX)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_BUILD_TYPE)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_PREFIX_PATH)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_VERBOSE_MAKEFILE)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_INSTALL_RPATH)

    set(${resultVariable} ${__cmake_vars} PARENT_SCOPE)

endfunction()


endif(NOT DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)
