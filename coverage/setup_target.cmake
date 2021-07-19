

function(__cmut__build__init_coverage)

    get_property(
        is_initialized
        GLOBAL
        PROPERTY __CMUT__BUILD__COVERAGE_INITIALIZED
        SET
        )
    if(is_initialized)
        return()
    endif()


    find_program( GCOV_COMMAND gcov )
    find_program( GCOVR_COMMAND gcovr )


    set(init_error OFF)
    if(NOT GCOV_COMMAND)
        cmut_error("[cmut][build][init_coverage] - gcov not found!")
        set(init_error ON)
    endif()
    if(NOT GCOVR_COMMAND)
        cmut_error("[cmut][build][init_coverage] - gcovr not found!")
        set(init_error ON)
    else()
        execute_process(
            COMMAND ${GCOVR_COMMAND} --version
            OUTPUT_VARIABLE gcovr_version_output)
        string(REGEX MATCH "^gcovr ([0-9]+\.[0-9]+)" result ${gcovr_version_output})
        if(CMAKE_MATCH_1 VERSION_LESS "4.2")
            cmut__log__error("cmut__build__init_coverage" "gcovr version 4.2 or greater is required.")
            set(init_error ON)
        endif()

    endif()
    if(NOT CMAKE_COMPILER_IS_GNUCXX)
        cmut_error("[cmut][build][init_coverage] - Compiler is not GNU gcc!")
        set(init_error ON)
    endif()
    if(init_error)
        cmut_fatal("[cmut][build][init_coverage] - initialization failed. Aborting ...")
    endif()


    set(CMAKE_CXX_FLAGS_COVERAGE
        "-g -O0 --coverage"
        CACHE STRING "Flags used by the CXX compiler during coverage builds."
        FORCE )
    set(CMAKE_C_FLAGS_COVERAGE
        "-g -O0 --coverage"
        CACHE STRING "Flags used by the C compiler during coverage builds."
        FORCE )
    set(CMAKE_EXE_LINKER_FLAGS_COVERAGE
        "--coverage"
        CACHE STRING "Flags used for linking binaries during coverage builds."
        FORCE )
    set(CMAKE_SHARED_LINKER_FLAGS_COVERAGE
        "--coverage"
        CACHE STRING "Flags used by the shared libraries linker during coverage builds."
        FORCE )
    mark_as_advanced(
        CMAKE_CXX_FLAGS_COVERAGE
        CMAKE_C_FLAGS_COVERAGE
        CMAKE_EXE_LINKER_FLAGS_COVERAGE
        CMAKE_SHARED_LINKER_FLAGS_COVERAGE )

    set_property(GLOBAL PROPERTY __CMUT__BUILD__COVERAGE_INITIALIZED ON)

endfunction()


function(cmut__coverage__setup_target target test_command )

    if(NOT CMAKE_BUILD_TYPE STREQUAL "Coverage")
        return()
    endif()


    __cmut__build__init_coverage()

    cmake_host_system_information(RESULT num_logical_cores QUERY NUMBER_OF_LOGICAL_CORES)

    cmut__lang__function__init_param(setup_target_for_coverage)
    cmut__lang__function__add_option(VERBOSE)
    cmut__lang__function__add_option(HIDE_SUMMARY)
    cmut__lang__function__add_option(XML_PRETTY)
    cmut__lang__function__add_option(JSON_PRETTY)
    cmut__lang__function__add_param(SORT_BY DEFAULT PATH)
    cmut__lang__function__add_param(XML_OUTPUT)
    cmut__lang__function__add_param(HTML_OUTPUT)
    cmut__lang__function__add_param(HTML_DETAILS_OUTPUT)
    cmut__lang__function__add_param(SONARQUBE_OUTPUT)
    cmut__lang__function__add_param(JSON_OUTPUT)
    cmut__lang__function__add_multi_param(EXCLUDE_REGEX)
    cmut__lang__function__add_param(JOB DEFAULT ${num_logical_cores})
    cmut__lang__function__parse_arguments(${ARGN})

    if(    (NOT DEFINED ARG_XML_OUTPUT)
       AND (NOT DEFINED ARG_HTML_OUTPUT)
       AND (NOT DEFINED ARG_HTML_DETAILS_OUTPUT)
       AND (NOT DEFINED ARG_SONARQUBE_OUTPUT)
       AND (NOT DEFINED ARG_JSON_OUTPUT) )
        set(ARG_HTML_DETAILS_OUTPUT coverage/index.html)
    endif()

    set(verbose_opt)
    if(ARG_VERBOSE)
        set(verbose_opt --verbose)
    endif()

    set(summary_opt)
    if(NOT ARG_HIDE_SUMMARY)
        set(summary_opt -s)
    endif()

    set(sort_by_opt)
    if(ARG_SORT_BY STREQUAL PERCENTAGE)
        set(sort_by_opt --sort-percentage)
    elseif(ARG_SORT_BY STREQUAL UNCOVERED)
        set(sort_by_opt --sort-uncovered)
    elseif(ARG_SORT_BY STREQUAL PATH)
        set(sort_by_opt)
    else()
        cmut_warn("[cmut][coverage][setup_target] - invalid value for SORT_BY parameter. Available value are : PATH, PERCENTAGE, UNCOVERED. Use PATH value as fallback.")
        set(sort_by_opt)
    endif()


    set(dir_to_create)
    macro(add_dir_to_create file)
        get_filename_component(directory ${file} DIRECTORY)
        list(APPEND dir_to_create ${directory})
    endmacro()

    set(xml_opt)
    if(DEFINED ARG_XML_OUTPUT)
        set(xml_opt --xml ${ARG_XML_OUTPUT})
        add_dir_to_create(${ARG_XML_OUTPUT})
        if(ARG_XML_PRETTY)
            list(APPEND xml_opt --xml-pretty)
        endif()
    endif()

    set(html_opt)
    if(DEFINED ARG_HTML_DETAILS_OUTPUT)
        set( html_opt --html-details ${ARG_HTML_DETAILS_OUTPUT} )
        add_dir_to_create(${ARG_HTML_DETAILS_OUTPUT})
    elseif(DEFINED ARG_HTML_OUTPUT)
        set( html_opt --html ${ARG_HTML_OUTPUT} )
        add_dir_to_create(${ARG_HTML_OUTPUT})
    endif()

    set(sonaqube_opt)
    if(DEFINED ARG_SONARQUBE_OUTPUT)
        set(sonaqube_opt --sonaqube ${ARG_SONARQUBE_OUTPUT})
        add_dir_to_create(${ARG_SONARQUBE_OUTPUT}})
    endif()

    set(json_opt)
    if(DEFINED ARG_JSON_OUTPUT)
        set(json_opt --json ${ARG_JSON_OUTPUT})
        add_dir_to_create(${ARG_JSON_OUTPUT}})
        if(ARG_JSON_PRETTY)
            list(APPEND json_opt --json-pretty)
        endif()
    endif()

    set(exclude_opt)
    if(DEFINED ARG_EXCLUDE_REGEX)
        foreach(pattern IN LISTS ARG_EXCLUDE_REGEX)
            list(APPEND exclude_opt -e "${pattern}")
        endforeach()
    endif()

    set(job_opt -j ${ARG_JOB})

    add_custom_target(${target}__run
        ${test_command} ${ARGV3}
        USES_TERMINAL
        COMMENT "Run command \"${test_command}\"."
        WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
        )

    add_custom_target(${target}
        ${CMAKE_COMMAND} -E make_directory ${dir_to_create}
        COMMAND ${GCOVR_COMMAND}
        -r ${PROJECT_SOURCE_DIR}
        ${exclude_opt}
        ${verbose_opt}
        ${summary_opt}
        ${sort_by_opt}
        ${xml_opt}
        ${html_opt}
        ${sonarqube_opt}
        ${json_opt}
        ${job_opt}
        ${PROJECT_BINARY_DIR}
        USES_TERMINAL
        COMMENT "collect counters and generate report."
        WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
        )
    add_dependencies(${target} ${target}__run)

    cmut_info("target \"${target}\" defined.")

endfunction()

function(cmut__build__add_coverage_target)

    if(NOT CMAKE_BUILD_TYPE STREQUAL "Coverage")
        return()
    endif()

    set(target coverage)
    if(TARGET ${target})
        return()
    endif()

    cmut__coverage__setup_target(
        ${target} ctest
        HTML_DETAIL_OUTPUT coverage/index.html
        SORT_BY PERCENTAGE
        EXCLUDE_REGEX "${PROJECT_SOURCE_DIR}/test/"
	${ARGN}
        )

endfunction()
