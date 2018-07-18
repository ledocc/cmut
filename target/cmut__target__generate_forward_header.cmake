
include("${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake")


set(__CMUT__TARGET__CREATE_FORWARD_HEADER__DEFAULT_MODEL "${CMAKE_CURRENT_LIST_DIR}/forward_header.cmake.in")

##
## cmut__target__generate_forward_header(target CLASS class1 ... [NAMESPACE namespace ...])
##
## @brief Generate a forward declaration for each class
## @param[in] target : target that have ownership of class(s)
## @param[in] CLASS : class(s) to forward
## @param[in] NAMESPACE : namespace(s) of class(s)
## @param[in] HEADER_EXTENSION : extension of generated header. default is ".h".
## @param[in] FORWARD_HEADER_MODEL : model to use in configure_file(...) function to generate header
##                variable available in this model are:
##                  - header_guard     : the header guard of the file
##                  - namespaces_begin : list of opening namespace scope
##                  - namespaces_end   : list of closing namespace scope
##                  - class_name       : name of the class
##
function(cmut__target__create_forward_header target)


    cmut__utils__parse_arguments(
        cmut__target__create_forward_header
        ARG
        ""
        "HEADER_EXTENSION;FORWARD_HEADER_MODEL"
        "CLASS;NAMESPACE"
        "${ARGN}"
        )

    cmut__utils__set_default_argument(ARG_HEADER_EXTENSION     ".h")
    cmut__utils__set_default_argument(ARG_FORWARD_HEADER_MODEL "${__CMUT__TARGET__CREATE_FORWARD_HEADER__DEFAULT_MODEL}")



    foreach(namespace IN LISTS ARG_NAMESPACE)

        string(APPEND header_dir "${namespace}/")

        string(APPEND  namespaces_begin "namespace ${namespace} {\n")
        string(PREPEND namespaces_end   "} // namespace ${namespace}\n")

    endforeach()



    foreach(class_name IN LISTS ARG_CLASS)

        set(header_path "${header_dir}${class_name}_fwd${ARG_HEADER_EXTENSION}")
        cmut_debug("[cmut][target] - Create forward declaration: '${header_path}'")

        cmut__utils__get_header_guard(header_guard ${header_path})

        configure_file("${ARG_FORWARD_HEADER_MODEL}" "include/${header_path}")

        list(APPEND forward_header_files "${header_path}")

        target_sources(
            ${target}
            PRIVATE
                "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include/${header_path}>"
        )

    endforeach()


    get_target_property(forward_header_property ${target} CMUT__TARGET__FORWARD_HEADER)
    if(forward_header_property)
        list(APPEND forward_header_files "${forward_header_property}")
    endif()
    set_target_properties(${target} PROPERTIES CMUT__TARGET__FORWARD_HEADER "${forward_header_files}")

endfunction()
