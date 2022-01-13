
include("${CMAKE_CURRENT_LIST_DIR}/../cmut_message.cmake")


set(__CMUT__TARGET__CREATE_FORWARD_HEADER__DEFAULT_MODEL "${CMAKE_CURRENT_LIST_DIR}/forward_header.cmake.in")

##
## cmut__target__generate_forward_header(target CLASS class1 ... [NAMESPACE namespace ...])
##
## @brief Generate a forward declaration for each class
## @param[in] target : target that have ownership of class(s)
## @param[in] CLASS : class(s) to forward
## @param[in] NAMESPACE : namespace(s) of class(s)
## @param[in] OUTPUT_DIR : ignored (deprecated)
## @param[in] HEADER_EXTENSION : extension of generated header. default is ".h".
## @param[in] FORWARD_HEADER_MODEL : model to use in configure_file(...) function to generate header
##                variable available in this model are:
##                  - header_guard     : the header guard of the file
##                  - namespaces_begin : list of opening namespace scope
##                  - namespaces_end   : list of closing namespace scope
##                  - class_name       : name of the class
##
function(cmut__target__create_forward_header target)

    cmut__lang__function__init_param( cmut__target__create_forward_header )
    cmut__lang__function__add_param( HEADER_EXTENSION     DEFAULT ".h" )
    cmut__lang__function__add_param( FORWARD_HEADER_MODEL DEFAULT "${__CMUT__TARGET__CREATE_FORWARD_HEADER__DEFAULT_MODEL}" )
    cmut__lang__function__add_param( OUTPUT_DIR )
    cmut__lang__function__add_multi_param( CLASS )
    cmut__lang__function__add_multi_param( NAMESPACE )
    cmut__lang__function__parse_arguments( ${ARGN} )

    if( ARG_OUTPUT_DIR )
        cmut_deprecated_parameter( OUTPUT_DIR )
    endif()


    cmut__target__get_generated_header_output_directory( output_dir )

    unset(header_dir)
    foreach(namespace IN LISTS ARG_NAMESPACE)

        string(APPEND header_dir "${namespace}/")

        string(APPEND  namespaces_begin "namespace ${namespace} {\n")
        string(PREPEND namespaces_end   "} // namespace ${namespace}\n")

    endforeach()

    foreach( class_name IN LISTS ARG_CLASS )

        set( header_path "${header_dir}${class_name}_fwd${ARG_HEADER_EXTENSION}" )
        cmut__utils__get_header_guard( header_guard ${header_path} )

        set( output_path "${output_dir}/${header_path}" )
        configure_file( "${ARG_FORWARD_HEADER_MODEL}" "${output_path}" )
        list( APPEND forward_header_files "${output_path}" )

        target_sources(
            ${target}
            PRIVATE
                "${output_path}"
        )

    endforeach()

    target_include_directories( ${target}
        PUBLIC
            "$<BUILD_INTERFACE:${output_dir}>"
    )

    cmut__target__get_property_prefix(prefix ${target})
    set_property( TARGET ${target} APPEND PROPERTY ${prefix}CMUT__TARGET__FORWARD_HEADERS ${forward_header_files} )

endfunction()

function( cmut__target__get_generated_forward_header_paths result target )

    cmut__target__get_property_prefix(prefix ${target})

    get_target_property( generated_forward_header_paths ${target} ${prefix}CMUT__TARGET__FORWARD_HEADERS )
    cmut__lang__return( generated_forward_header_paths )

endfunction()
