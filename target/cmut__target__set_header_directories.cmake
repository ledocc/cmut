
function( cmut__target__set_header_directories target scope )
    set( valid_scope PUBLIC PRIVATE INTERFACE )
    if( NOT scope IN_LIST valid_scope )
        cmut__log__error( cmut__target__set_header_directories "invalid scope \"${scope}\", valid scope are PUBLIC, PRIVATE or INTERFACE." )
        return()
    endif()

    foreach( header_directory IN LISTS ARGN )
        __cmut__target__set_header_directory( ${target} ${scope} ${header_directory} )
    endforeach()
endfunction()

function( cmut__target__set_public_header_directories target )
    foreach( header_directory IN LISTS ARGN )
        __cmut__target__set_header_directory( ${target} PUBLIC ${header_directory} )
    endforeach()
endfunction()

function( cmut__target__set_private_header_directories target )
    foreach( header_directory IN LISTS ARGN )
        __cmut__target__set_header_directory( ${target} PRIVATE ${header_directory} )
    endforeach()
endfunction()



function( __cmut__target__set_header_directory target scope header_directory )

    set_property( TARGET ${target}
        APPEND
        PROPERTY CMUT__TARGET__${scope}__HEADER_DIRECTORIES
        "${header_directory}"
        )

    get_filename_component( parent_header_directory "${header_directory}" DIRECTORY )
    file( RELATIVE_PATH install_header_directory "${PROJECT_SOURCE_DIR}" "${parent_header_directory}" )
    target_include_directories( ${target}
        ${scope}
            "$<BUILD_INTERFACE:${parent_header_directory}>"
            "$<INSTALL_INTERFACE:$<INSTALL_PREFIX>/${install_header_directory}>"
        )

endfunction()
