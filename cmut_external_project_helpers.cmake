if(NOT DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)
set(${CMAKE_CURRENT_LIST_FILE}_include "1")

include(cmut_define_num_core_available)
include("${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__parse_version.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utils/cmut_message.cmake")
cmut_warn("cmut_external_project_helpers is deprecated. \"Use https://github.com/ledocc/byd.git\" instead")


cmake_policy(VERSION 3.5.2)

include(CMakePrintHelpers)
include(cmut_message)


set(__CMUT_EP_TO_BUILD_PREFIX CMUT_EP_)


# Transform version string to string acceptable as variable name by cmake
# replace any non alphanum character by '_'
function(__cmut_EP_version_to_name version result)
    string(REGEX REPLACE "[^0-9a-zA-Z]" "_" __version_result ${version})
    set(${result} ${__version_result} PARENT_SCOPE)
endfunction()


macro(__cmut_EP_add_module_to_build_list name)
    list(APPEND __CMUT_EP_MODULE_TO_BUILD ${name})
endmacro()

macro(cmut_EP_add_optional_module name)
    option(CMUT_EP_${name} OFF "Enable build of ${name}")
    __cmut_EP_add_module_to_build_list(${name})
endmacro()

macro(cmut_EP_add_module name)
    set(CMUT_EP_${name} ON)
    __cmut_EP_add_module_to_build_list(${name})


    set(options "")
    set(oneValueArgs VERSION)
    set(multiValueArgs OPTIONS)
    cmake_parse_arguments(
        __CMUT_EP_ADD_MODULE
        "${options}" "${oneValueArgs}" "${multiValueArgs}"
        ${ARGN}
    )


    if(__CMUT_EP_ADD_MODULE_VERSION)
        cmut_define_EP_version(${name} ${__CMUT_EP_ADD_MODULE_VERSION})
    endif()

endmacro()

macro(cmut_define_EP_version name version)
    set(CMUT_EP_${name}_VERSION ${version} CACHE STRING "${name} version to build")
    __cmut_ep_version_to_name(${CMUT_EP_${name}_VERSION} CMUT_EP_${name}_VERSION_NAME)
    variable_watch(CMUT_EP_${name}_VERSION __cmut_EP__on_change_version_name)

    cmut__utils__parse_version(${version} CMUT_EP_${name}_VERSION_MAJOR
                                          CMUT_EP_${name}_VERSION_MINOR
                                          CMUT_EP_${name}_VERSION_PATCH)

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
        if(DEFINED CMUT_EP_${dependency})
            if(CMUT_EP_${dependency})
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

    set(__dependencies_file ${PROJECT_SOURCE_DIR}/${CMUT_MODULE_PREFIX}/${name}/dependencies.cmake)

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

        if(CMUT_EP_${module})

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




function(__cmut_EP__on_change_version_name variable access value current_list_file stack)

    if(${access} STREQUAL "MODIFIED_ACCESS")
    message(WARNING "variable = ${variable}")
    message(WARNING "access = ${access}")
    message(WARNING "value = ${value}")
    message(WARNING "current_list_file = ${current_list_file}")
    message(WARNING "stack = ${stack}")
        set(${variable}_save "toto" CACHE STRING "${name} version to build")
        __cmut_ep_version_to_name(${value} CMUT_EP_${name}_VERSION_NAME)
    endif()
endfunction()







macro(cmut_EP_add_variable_if_defined __list __variable)
    if(${__variable})
        list(APPEND ${__list} "-D${__variable}=${${__variable}}")
    endif()
endmacro()

function(cmut_EP_collect_cmake_variable resultVariable)

    set(__cmake_vars)

    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_TOOLCHAIN_FILE)

    cmut_EP_add_variable_if_defined(__cmake_vars BUILD_SHARED_LIBS)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_INSTALL_PREFIX)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_BUILD_TYPE)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_PREFIX_PATH)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_VERBOSE_MAKEFILE)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_INSTALL_RPATH)

    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_OSX_ARCHITECTURES)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_OSX_DEPLOYMENT_TARGET)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_OSX_SYSROOT)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_MACOSX_RPATH)

    set(${resultVariable} ${__cmake_vars} PARENT_SCOPE)

endfunction()



macro(cmut_EP_add_config_arg)
    if(NOT module)
        cmut_error("\"module\" variable not defined. Can't use cmut_EP_* macro.")
    endif()
    cmut_debug("cmut_EP_add_config_arg( ${ARGN} )")
    list(APPEND CMUT_EP_${module}_CONFIG_ARG "${ARGN}")
endmacro()

macro(cmut_EP_add_config_arg_if test true_arg false_arg)
    if(${test})
        cmut_EP_add_config_arg("${true_arg}")
    else()
        cmut_EP_add_config_arg("${false_arg}")
    endif()
endmacro()



macro(cmut_EP_autotools_adapt_cmake_var)
   cmut_EP_add_config_arg("--prefix=${CMAKE_INSTALL_PREFIX}")
   cmut_EP_add_config_arg_if(BUILD_SHARED_LIBS "--enable-shared;--disable-static" "--disable-shared;--enable-static")

   if(CMAKE_CROSSCOMPILING)
       if(NOT CMAKE_CROSSCOMPILE_TRIPLET)
           cmut_fatal("cross compiling detected but \"CMAKE_CROSSCOMPILE_TRIPLET\" not defined. CMAKE_CROSSCOMPILE_TRIPLET is required to build autotools base project.")
           cmut_EP_add_config_arg("--host=${CMAKE_CROSSCOMPILE_TRIPLET}")
       endif()
   endif()
endmacro()




set(CMUT_EP_AUTOTOOLS_CONFIGURE_CMD configure)
macro(cmut_EP_autotools_config_build_install_command)
    set(CMUT_EP_${module}_CONFIGURE_CMD export PKG_CONFIG_PATH=${CMAKE_INSTALL_PREFIX}/lib/pkgconfig && ../${module}/${CMUT_EP_AUTOTOOLS_CONFIGURE_CMD} "${CMUT_EP_${module}_CONFIG_ARG}")
    set(CMUT_EP_${module}_BUILD_CMD     ${CMAKE_MAKE_PROGRAM} -j${CMUT_NUM_CORE_AVAILABLE})
    set(CMUT_EP_${module}_INSTALL_CMD   ${CMAKE_MAKE_PROGRAM} install)
endmacro()

macro(cmut_EP_cmake_config_build_install_command)

    set(CMAKE_COMMAND_BUILD_OPTS)
    if((${CMAKE_MAKE_PROGRAM} MATCHES ".*/make$") OR (${CMAKE_MAKE_PROGRAM} MATCHES ".*/jom$"))
        set(CMAKE_COMMAND_BUILD_OPTS -- -j${CMUT_NUM_CORE_AVAILABLE})
    endif()

    set(CMUT_EP_${module}_CONFIGURE_CMD ${CMAKE_COMMAND} "${CMUT_EP_${module}_CONFIG_ARG}" "../${module}")
    set(CMUT_EP_${module}_BUILD_CMD     ${CMAKE_COMMAND} --build . ${CMAKE_COMMAND_BUILD_OPTS})
    set(CMUT_EP_${module}_INSTALL_CMD   ${CMAKE_COMMAND} --build . --target install ${CMAKE_COMMAND_BUILD_OPTS})
endmacro()

macro(cmut_EP_assemble_config_build_install_command)

    __cmut_EP_test_variable(module)
    __cmut_EP_test_variable(CMUT_EP_${module}_CONFIGURE_CMD)
    __cmut_EP_test_variable(CMUT_EP_${module}_BUILD_CMD)
    __cmut_EP_test_variable(CMUT_EP_${module}_INSTALL_CMD)


    set(CMUT_EP_${module}_CONFIG_BUILD_INSTALL
        CONFIGURE_COMMAND
            ${CMUT_EP_${module}_CONFIGURE_CMD}
        BUILD_COMMAND
            ${CMUT_EP_${module}_BUILD_CMD}
        INSTALL_COMMAND
            ${CMUT_EP_${module}_INSTALL_CMD}
        )

endmacro()







function(cmut_EP_add_version name version)

    __cmut_EP_version_to_name(${version} version_name)

    set(CMUT_EP_${name}_${version_name}_DOWNLOAD_CMD "${ARGN}" PARENT_SCOPE)

endfunction()



function(__cmut_EP_test_variable var)

    if (NOT ${var})
        cmut_fatal("cmake variable \"${var}\" not defined. abort.")
    endif()
endfunction()


function(cmut_EP_assemble_download_command)

    __cmut_EP_test_variable(module)
    __cmut_EP_test_variable(CMUT_EP_${module}_VERSION_NAME)
    __cmut_EP_test_variable(CMUT_EP_${module}_${CMUT_EP_${module}_VERSION_NAME}_DOWNLOAD_CMD)


    set(CMUT_EP_${module}_DOWNLOAD_CMD
        ${CMUT_EP_${module}_${CMUT_EP_${module}_VERSION_NAME}_DOWNLOAD_CMD}
        PARENT_SCOPE)

endfunction()

function(cmut_EP_assemble_update_command)
    set(CMUT_EP_${module}_UPDATE_CMD
        UPDATE_COMMAND ${CMUT_EP_${module}_UPDATE_CMD}
        PARENT_SCOPE)
endfunction()

function(cmut_EP_assemble_log_command)

    __cmut_EP_test_variable(module)

    set(
        CMUT_EP_${module}_LOG_CMD___disable
        LOG_DOWNLOAD 1
        LOG_UPDATE 1
        LOG_CONFIGURE 1
        LOG_BUILD 1
        LOG_TEST 1
        LOG_INSTALL 1
	PARENT_SCOPE
    )

endfunction()


function(cmut_EP_assemble_command_and_define_external_project module)

    cmut_EP_assemble_download_command()
    cmut_EP_assemble_update_command()
    cmut_EP_assemble_config_build_install_command()
    cmut_EP_assemble_log_command()

    if(DEFINED CMUT_EP_PREFIX)
        set(CMUT_EP_${module}_PREFIX PREFIX ${CMUT_EP_PREFIX}/${module})
    endif()

    include(ExternalProject)
    ExternalProject_Add(
        ${module}
        ${CMUT_EP_${module}_PREFIX}
        DEPENDS ${CMUT_EP_${module}_DEPENDS}
        ${CMUT_EP_${module}_DOWNLOAD_CMD}
        TIMEOUT ${CMUT_EP_DOWNLOAD_TIMEOUT}
        BUILD_IN_SOURCE ${CMUT_EP_${module}_BUILD_IN_SOURCE}
        ${CMUT_EP_${module}_UPDATE}
        ${CMUT_EP_${module}_CONFIG_BUILD_INSTALL}
        ${CMUT_EP_${module}_LOG_CMD}
)

endfunction()




endif(NOT DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)
