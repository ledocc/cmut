



if(NOT TARGET Boost::system_header_only)
    add_library(Boost::system_header_only INTERFACE IMPORTED)
    set_target_properties( Boost::system_header_only PROPERTIES
        INTERFACE_COMPILE_DEFINITIONS BOOST_ERROR_CODE_HEADER_ONLY)        
endif()
