
include("${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake")

##
## cmut__utils__create_forward( result_header_list class_name [namespace ...])
##
## @brief Generate a generic forward declaration 
## @param[out] result_header_list add absolute header name in the list
## @param[in] class_name Class name
## @param[in] namespace multiple argument or namespaces
##
function(cmut__utils__create_forward result_headers class_name)
    set(PARSED_ARGS__DESTINATION_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

    # create destination filename
    set(header_file "")
    foreach(namespace ${ARGN})
        string(CONCAT header_file "${header_file}" "${namespace}/")
    endforeach()
    string(CONCAT header_file "${header_file}" "${class_name}_fwd.h")
    set(header_file_absolute "${PARSED_ARGS__DESTINATION_DIRECTORY}/include/${header_file}")
    cmut_info("Create forward declaration: '${header_file}'")

    # check if we need to regenerate the file
    if(   NOT EXISTS "${header_file}"
       OR "${CMAKE_CURRENT_LIST_FILE}" IS_NEWER_THAN "${header_file}")
        
        get_filename_component(input_name "${header_file}" NAME)
        cmut__utils__get_header_guard(header_guard ${header_file})
        
        # Generate all the HEADER file:
        cmut_info("Generate file: '${header_file_absolute}'" )
        set(header_file_content "/** @file
  * @brief Forward declaration of class : ${class_name}
  * @note Auto-generated file with cmake
  */
#ifndef ${header_guard}
#define ${header_guard}

#include <memory>

")
        foreach(namespace ${ARGN})
            string(APPEND header_file_content "
namespace ${namespace} {
")
        endforeach()

        string(APPEND header_file_content "
class ${class_name};

using ${class_name}Ptr = std::shared_ptr<${class_name}>;
using ${class_name}ConstPtr = std::shared_ptr<const ${class_name}>;

using ${class_name}WPtr = std::weak_ptr<${class_name}>;
using ${class_name}WConstPtr = std::weak_ptr<const ${class_name}>;

using ${class_name}UPtr = std::unique_ptr<${class_name}>;
using ${class_name}UConstPtr = std::unique_ptr<const ${class_name}>;

")
        foreach(namespace ${ARGN})
            string(APPEND header_file_content "}
")
        endforeach()

        string(APPEND header_file_content "
#endif // ${header_guard}
 ")
        file(WRITE "${header_file_absolute}" "${header_file_content}")
    endif()

    list(APPEND ${result_headers} "${header_file_absolute}")
    set(${result_headers} ${${result_headers}} PARENT_SCOPE)

    cmut_info("Create forward declaration: '${header_file}' ==> DONE" )
endfunction()
