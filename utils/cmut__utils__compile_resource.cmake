
include("${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake")


##--------------------------------------------------------------------------------------------------------------------##

function(cmut__utils__get_file_name result input_file output_dir extention)

    get_filename_component(input_name "${input_file}" NAME)

    set(path "${input_name}.${extention}" PARENT_SCOPE)
    if(NOT "${output_dir}" STREQUAL "")
        set(path "${output_dir}/${path}")
    endif ()

    set(${result} "${path}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(cmut__utils__get_header_guard result input_file)

    string(REGEX REPLACE "[/\\]" "__" header_guard "${input_file}")
    string(REGEX REPLACE "[^a-zA-Z0-9]" "_" header_guard "${header_guard}")

    set(${result} "${header_guard}" PARENT_SCOPE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(cmut__utils__create_header_from_file input_file header_file source_file namespace variable_name)

    # Check if the input file exist:
    if( NOT EXISTS "${input_file}" )
        cmut_fatal("cmut__utils__create_header_from_file: \"${input_file}\" : no such file." )
    endif()

    cmut_info(" cmut__utils__create_header_from_file: File: \"${input_file}\"" )

    # Read the data form the input file
    file(READ "${input_file}" contents HEX)
    string(REGEX MATCHALL ".." output "${contents}")
    string(REGEX REPLACE ";" "),\n  static_cast<std::uint8_t>(0x" output "${output}")




    get_filename_component(input_name "${input_file}" NAME)
    cmut__utils__get_header_guard(header_guard ${header_file})

    # Generate all the HEADER file:
    cmut_info(" Generate file: '${header_file}'" )
    set(header_file_content
"
/** @file
  * @brief Include header in a C++ header
  * @note Auto-generated file with cmake
  */

#ifndef ${header_guard}
#define ${header_guard}



#include <cstdint>
#include <string>
#include <vector>



namespace ${namespace} {

/**
 * @brief Data Raw of the file
 */
extern std::vector<std::uint8_t> ${variable_name};

/**
 * @brief Worktree name of the file
 */
extern std::string ${variable_name}__FileName;

} // namespace ${namespace}

#endif // ${header_guard}
")
    file(WRITE "${header_file}" "${header_file_content}")
    cmut_info("     ==> DONE" )


    # Generate all the SOURCE file:
    cmut_info(" Generate file: \"${source_file}\"" )
    set(source_file_content
"
/** @file
  * @brief Include header in a C++ header
  * @note Auto-generated file with cmake
  */

#include \"${header_file}\"

namespace ${namespace} {

std::vector<uint8_t> ${variable_name} = {
    static_cast<std::uint8_t>(0x${output})
};

std::string ${variable_name}__FileName = \"${input_file}\";

} // namespace ${namespace}
")

    file(WRITE "${source_file}" "${source_file_content}")
    cmut_info("     ==> DONE" )
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

##
## cmut__utils__generate_header_from_file( result_header_name result_source_name
##     SOURCE source_file
##     [DESTINATION_DIRECTORY dir]
##     [OUTPUT_FILE_NAME filename]
##     [NAMESPACE namespace]
##     [VARIABLE_NAME var]
##     )
##
## @brief create header.hpp (result_header_name) and code.cpp (result_source_name) with the binary file SOURCE
## @param[out] result_header_name Generate absolute file for header
## @param[out] result_source_name Generate absolute file for source
## @param[in] SOURCE xxx (required) Input file that need to be converted in CPP
## @param[in] DESTINATION_DIRECTORY xxx (optionnal) Ouput directory (generate file folder)
## @param[in] OUTPUT_FILE_NAME xxx (optionnal) Output basename generated file
## @param[in] NAMESPACE xxx (optionnal) namespace whre to set the variable (default: "generateFile")
## @param[in] VARIABLE_NAME xxx (optionnal) Variable name inside the file (default generated with the filename)
##
function(cmut__utils__generate_header_from_file result_header_name result_source_name)

    cmut__utils__parse_arguments(
        cmut__utils__generate_header_from_file
        PARSED_ARGS_
        ""
        "SOURCE;DESTINATION_DIRECTORY;OUTPUT_FILE_NAME;NAMESPACE;VARIABLE_NAME"
        ""
        ${ARGN}
        )


    if(NOT DEFINED PARSED_ARGS__SOURCE)
        cmut_fatal("SOURCE argument is required")
    endif()

    if(NOT DEFINED PARSED_ARGS__DESTINATION_DIRECTORY)
        set(PARSED_ARGS__DESTINATION_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")
    endif()

    if(DEFINED PARSED_ARGS__OUTPUT_FILE_NAME)
        set(header_file "${PARSED_ARGS__DESTINATION_DIRECTORY}/${PARSED_ARGS__OUTPUT_FILE_NAME}.h")
        set(source_file "${PARSED_ARGS__DESTINATION_DIRECTORY}/${PARSED_ARGS__OUTPUT_FILE_NAME}.cpp")
    else()
        cmut__utils__get_file_name(header_file "${PARSED_ARGS__SOURCE}" "${PARSED_ARGS__DESTINATION_DIRECTORY}" "h")
        cmut__utils__get_file_name(source_file "${PARSED_ARGS__SOURCE}" "${PARSED_ARGS__DESTINATION_DIRECTORY}" "cpp")
    endif()

    if(NOT PARSED_ARGS__NAMESPACE)
        set(PARSED_ARGS__NAMESPACE "cmutCompiledResource")
    endif()

    if(NOT PARSED_ARGS__VARIABLE_NAME)
        get_filename_component(source_file_name "${PARSED_ARGS__SOURCE}" NAME)
        cmut__utils__value_to_variable_name(PARSED_ARGS__VARIABLE_NAME "${source_file_name}")
    endif()


    cmut_info(" Single file Generation : ${PARSED_ARGS__SOURCE}" )
    cmut_info("     directory: ${PARSED_ARGS__DESTINATION_DIRECTORY}" )
    cmut_info("     header: ${header_file}" )
    cmut_info("     source: ${source_file}" )
    cmut_info("     namespace: ${PARSED_ARGS__NAMESPACE}" )
    cmut_info("     variable name: ${PARSED_ARGS__VARIABLE_NAME}" )


    if(   NOT EXISTS "${header_file}"
       OR NOT EXISTS "${source_file}"
       OR "${PARSED_ARGS__SOURCE}" IS_NEWER_THAN "${header_file}"
       OR "${PARSED_ARGS__SOURCE}" IS_NEWER_THAN "${source_file}"
       OR "${CMAKE_CURRENT_LIST_FILE}" IS_NEWER_THAN "${header_file}"
       OR "${CMAKE_CURRENT_LIST_FILE}" IS_NEWER_THAN "${source_file}")

        cmut__utils__create_header_from_file("${PARSED_ARGS__SOURCE}"
            "${header_file}" "${source_file}"
            "${PARSED_ARGS__NAMESPACE}"
            "${PARSED_ARGS__VARIABLE_NAME}"
            )
    endif()

    set(${result_header_name} "${header_file}" PARENT_SCOPE)
    set(${result_source_name} "${source_file}" PARENT_SCOPE)


    cmut_info(" Single file Generation : '${PARSED_ARGS__SOURCE}' ==> DONE" )

endfunction()
