
include(CMakeParseArguments)
include("${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake")


function(cmut__utils__get_file_name result INPUT_FILE OUTPUT_FOLDER EXTENTION)
    cmut__utils__value_to_variable_name(SOURCE_FILE_NAME_VARIABLE "${INPUT_FILE}")
    # create Name ouf output files .h & .cpp
    if ("${OUTPUT_FOLDER}" STREQUAL "")
        set(${result} "GENERATED__${SOURCE_FILE_NAME_VARIABLE}.${EXTENTION}" PARENT_SCOPE)
    else ()
        set(${result} "${OUTPUT_FOLDER}/GENERATED__${SOURCE_FILE_NAME_VARIABLE}.${EXTENTION}" PARENT_SCOPE)
    endif ()
    cmut_info(" cmut__utils__get_file_name: Generate name: ${result}" )
endfunction()

function(cmut__utils__get_header_guard result INPUT_FILE)
    # create The header multiple include lock
    string(TOLOWER "${INPUT_FILE}" HEADER_LOCK)
    string(REGEX REPLACE "/" "__" HEADER_LOCK "${HEADER_LOCK}")
    string(REGEX REPLACE "[^a-z0-9]" "_" HEADER_LOCK "${HEADER_LOCK}")
    # create Name ouf output files .h & .cpp
    set(${result} "${HEADER_LOCK}" PARENT_SCOPE)
endfunction()

function(cmut__utils__create_header_from_file INPUT_FILE FILE_HEADER FILE_SOURCE NAMESPACE VARIABLE_NAME)
    # Check if the input file exist:
    if ( NOT DEFINED INPUT_FILE )
        cmut_fatal("cmut__utils__create_header_from_file: File does not exist: '${INPUT_FILE}'" )
    endif()
    cmut_info(" cmut__utils__create_header_from_file: File: '${INPUT_FILE}'" )
    # Read the data form the input file
    file(READ "${INPUT_FILE}" contents HEX)
    get_filename_component(SOURCE_FILE_NAME "${INPUT_FILE}" NAME)
    cmut__utils__value_to_variable_name(SOURCE_FILE_NAME_VARIABLE "${INPUT_FILE}")
    cmut__utils__get_header_guard(HEADER_LOCK ${FILE_HEADER})
    # Generate all the HEADER file:
    cmut_info(" Generate file: '${FILE_HEADER}'" )
    file(WRITE "${FILE_HEADER}" "/** @file\n")
    file(APPEND "${FILE_HEADER}" " * @brief Include header in a C++ header\n")
    file(APPEND "${FILE_HEADER}" " * @note Auto-generated file with cmake\n")
    file(APPEND "${FILE_HEADER}" " */\n")
    file(APPEND "${FILE_HEADER}" "\n")
    file(APPEND "${FILE_HEADER}" "#ifndef ${HEADER_LOCK}\n")
    file(APPEND "${FILE_HEADER}" "#define ${HEADER_LOCK}\n")
    file(APPEND "${FILE_HEADER}" "\n")
    file(APPEND "${FILE_HEADER}" "#include <string>\n")
    file(APPEND "${FILE_HEADER}" "#include <vector>\n")
    file(APPEND "${FILE_HEADER}" "#include <cstdint>\n")
    file(APPEND "${FILE_HEADER}" "\n")
    file(APPEND "${FILE_HEADER}" "/**\n")
    file(APPEND "${FILE_HEADER}" " * @brief Name space of all auto-generateFile\n")
    file(APPEND "${FILE_HEADER}" " */\n")
    # TODO: Add a user namespace
    file(APPEND "${FILE_HEADER}" "namespace ${NAMESPACE} {\n")
    file(APPEND "${FILE_HEADER}" "\n")
    file(APPEND "${FILE_HEADER}" "/**\n")
    file(APPEND "${FILE_HEADER}" " * @brief Data Raw of the file\n")
    file(APPEND "${FILE_HEADER}" " */\n")
    file(APPEND "${FILE_HEADER}" "extern std::vector<std::uint8_t> ${VARIABLE_NAME};\n")
    file(APPEND "${FILE_HEADER}" "\n")
    file(APPEND "${FILE_HEADER}" "/**\n")
    file(APPEND "${FILE_HEADER}" " * @brief Worktree name of the file\n")
    file(APPEND "${FILE_HEADER}" " */\n")
    file(APPEND "${FILE_HEADER}" "extern std::string ${VARIABLE_NAME}__FileName;\n")
    file(APPEND "${FILE_HEADER}" "\n")
    file(APPEND "${FILE_HEADER}" "} // namespace ${NAMESPACE}\n")
    file(APPEND "${FILE_HEADER}" "\n")
    file(APPEND "${FILE_HEADER}" "#endif // ${HEADER_LOCK} header_guard\n")
    cmut_info("     ==> DONE" )
    # Generate all the SOURCE file:
    cmut_info(" Generate file: '${FILE_SOURCE}'" )
    file(WRITE "${FILE_SOURCE}" "/** @file\n")
    file(APPEND "${FILE_SOURCE}" " * @brief Include header in a C++ header\n")
    file(APPEND "${FILE_SOURCE}" " * @note Auto-generated file with cmake\n")
    file(APPEND "${FILE_SOURCE}" " */\n")
    file(APPEND "${FILE_SOURCE}" "\n")
    file(APPEND "${FILE_SOURCE}" "#include \"${FILE_HEADER}\"\n")
    file(APPEND "${FILE_SOURCE}" "\n")
    file(APPEND "${FILE_SOURCE}" "namespace ${NAMESPACE} {\n")
    file(APPEND "${FILE_SOURCE}" "\n")
    file(APPEND "${FILE_SOURCE}" "std::vector<uint8_t> ${VARIABLE_NAME} = {\n")
    string(REGEX MATCHALL ".." output "${contents}")
    string(REGEX REPLACE ";" "),\n  static_cast<std::uint8_t>(0x" output "${output}")
    file(APPEND "${FILE_SOURCE}" "  static_cast<std::uint8_t>(0x${output})\n")
    file(APPEND "${FILE_SOURCE}" "};\n")
    file(APPEND "${FILE_SOURCE}" "\n")
    file(APPEND "${FILE_SOURCE}" "std::string ${VARIABLE_NAME}__FileName = \"${SOURCE_FILE_NAME}\";\n")
    file(APPEND "${FILE_SOURCE}" "\n")
    file(APPEND "${FILE_SOURCE}" "} // namespace ${NAMESPACE}\n")
    file(APPEND "${FILE_SOURCE}" "\n")
    cmut_info("     ==> DONE" )
endfunction()

##
## @brief create header.hpp (result_header_name) and code.cpp (result_source_name) with the binary file SOURCE
## @param[out] result_header_name Generate absolute file for header
## @param[out] result_source_name Generate absolute file for source
## @param[in] SOURCE xxx (optionnal) Inut file that need to be converted in CPP
## @param[in] DESTINATION_DIRECTORY xxx (optionnal) Ouput directory (generate file folder)
## @param[in] OUTPUT_FILE_NAME xxx (optionnal) Output basename generated file
## @param[in] NAMESPACE xxx (optionnal) namespace whre to set the variable (default: "generateFile")
## @param[in] VARIABLE_NAME xxx (optionnal) Variable name inside the file (default denerated with the filename)
##
function(cmut__utils__generate_header_from_file result_header_name result_source_name)
    cmake_parse_arguments(
        PARSED_ARGS_ # prefix of output variables
        "" # list of names of the boolean arguments (only defined ones will be true)
        "SOURCE;DESTINATION_DIRECTORY;OUTPUT_FILE_NAME;NAMESPACE;VARIABLE_NAME" # list of names of mono-valued arguments
        "" # list of names of multi-valued arguments (output variables are lists)
        ${ARGN} # arguments of the function to parse, here we take the all original ones
    )
    #cmut_info(" args: ${ARGN}" )
    #cmut_info(" PARSED_ARGS__SOURCE: ${PARSED_ARGS__SOURCE}" )
    #cmut_info(" PARSED_ARGS__DESTINATION_DIRECTORY: ${PARSED_ARGS__DESTINATION_DIRECTORY}" )
    #cmut_info(" PARSED_ARGS__OUTPUT_FILE_NAME: ${PARSED_ARGS__OUTPUT_FILE_NAME}" )
    #cmut_info(" PARSED_ARGS__NAMESPACE: ${PARSED_ARGS__NAMESPACE}" )
    #cmut_info(" PARSED_ARGS__VARIABLE_NAME: ${PARSED_ARGS__VARIABLE_NAME}" )
    if(NOT DEFINED PARSED_ARGS__SOURCE)
        cmut_fatal(FATAL_ERROR "Missing source name")
    endif()
    if(NOT DEFINED PARSED_ARGS__DESTINATION_DIRECTORY)
        set(PARSED_ARGS__DESTINATION_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")
    endif()
    if(DEFINED PARSED_ARGS__OUTPUT_FILE_NAME)
        set(FILE_HEADER "${PARSED_ARGS__DESTINATION_DIRECTORY}/${PARSED_ARGS__OUTPUT_FILE_NAME}.h")
        set(FILE_SOURCE "${PARSED_ARGS__DESTINATION_DIRECTORY}/${PARSED_ARGS__OUTPUT_FILE_NAME}.cpp")
    else()
        cmut__utils__get_file_name(FILE_HEADER "${PARSED_ARGS__SOURCE}" "${PARSED_ARGS__DESTINATION_DIRECTORY}" "h")
        cmut__utils__get_file_name(FILE_SOURCE "${PARSED_ARGS__SOURCE}" "${PARSED_ARGS__DESTINATION_DIRECTORY}" "cpp")
    endif()
    if(NOT PARSED_ARGS__NAMESPACE)
        set(PARSED_ARGS__NAMESPACE "generateFile")
    endif()
    if(NOT PARSED_ARGS__VARIABLE_NAME)
        cmut__utils__value_to_variable_name(PARSED_ARGS__VARIABLE_NAME "${PARSED_ARGS__SOURCE}")
    endif()
    
    cmut_info(" Single file Generation : ${PARSED_ARGS__SOURCE}" )
    cmut_info("     directory: ${PARSED_ARGS__DESTINATION_DIRECTORY}" )
    cmut_info("     PARSED_ARGS__OUTPUT_FILE_NAME: ${PARSED_ARGS__OUTPUT_FILE_NAME}" )
    cmut_info("     header: ${FILE_HEADER}" )
    cmut_info("     source: ${FILE_SOURCE}" )
    cmut_info("     namespace: ${PARSED_ARGS__NAMESPACE}" )
    cmut_info("     variable name: ${PARSED_ARGS__VARIABLE_NAME}" )
    
    if(   NOT EXISTS "${FILE_HEADER}"
       OR NOT EXISTS "${FILE_SOURCE}"
       OR "${PARSED_ARGS__SOURCE}" IS_NEWER_THAN "${FILE_HEADER}"
       OR "${PARSED_ARGS__SOURCE}" IS_NEWER_THAN "${FILE_SOURCE}"
       OR "${CMAKE_CURRENT_LIST_FILE}" IS_NEWER_THAN "${FILE_HEADER}"
       OR "${CMAKE_CURRENT_LIST_FILE}" IS_NEWER_THAN "${FILE_SOURCE}")
        cmut__utils__create_header_from_file("${PARSED_ARGS__SOURCE}" "${FILE_HEADER}" "${FILE_SOURCE}" "${PARSED_ARGS__NAMESPACE}" "${PARSED_ARGS__VARIABLE_NAME}")
    endif()
    set(${result_header_name} "${FILE_HEADER}" PARENT_SCOPE)
    set(${result_source_name} "${FILE_SOURCE}" PARENT_SCOPE)
    cmut_info(" Single file Generation : '${INPUT_FILE}' ==> DONE" )
endfunction()





