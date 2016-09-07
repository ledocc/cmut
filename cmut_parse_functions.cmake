#-----------------------------------------------------------------------------
# common install command for simple project
#-----------------------------------------------------------------------------

include("${CMAKE_CURRENT_LIST_DIR}/cmut_deprecated.cmake")
cmut_deprecated("cmut_parse_function.cmake" "build/cmut__utils__parse_arguments.cmake")


function( cmut_increment VALUE )
    math( EXPR ${VALUE} "${${VALUE}} + 1" )
    set(${VALUE} ${${VALUE}} PARENT_SCOPE )
endfunction()

function( cmut_decrement VALUE )
    math( EXPR ${VALUE} "${${VALUE}} - 1" )
    set(${VALUE} ${${VALUE}} PARENT_SCOPE )
endfunction()

# prototype parse_args( TYPE_ARG_NAME ARGS_LIST TYPE_ARGS_LIST RESULTS )
#
# comment : parse arguments list and find arguments for specific type argument name 
# for cmake command : 
# set(<variable> <value>
#     [[CACHE <type> <docstring> [FORCE]] | PARENT_SCOPE])
# CACHE, FORCE and PARENT_SCOPE are TYPE_ARG, 
# <variable> <value> <type> <docstring> are argument
#
# param:
# TYPE_ARG_NAME  = specific type argument name that arguments have to be found
# ARGS_LIST      = complete list of arguments to parse
# TYPE_ARGS_LIST = list of type of arguments
# RESULTS        = list of argument found for specific type argument name TYPE_ARG_NAME
function( cmut_parse_args TYPE_ARG_NAME ARGS_LIST TYPE_ARGS_LIST RESULTS)


    # loop in LOCAL_ARGS_LIST
    foreach( ARG IN LISTS ${ARGS_LIST} )
        
        list( REMOVE_AT ${ARGS_LIST} 0 )
        if ( ${ARG} STREQUAL ${TYPE_ARG_NAME} )
        
            foreach( SEARCHED_ARG IN LISTS ${ARGS_LIST} )
            
                # current arg is a "type name arg" ?
                list(FIND ${TYPE_ARGS_LIST} ${SEARCHED_ARG} FIND_RESULT)
                
                # if no, append arg to result list 
                # if yes, break the loop
                if ( ${FIND_RESULT} EQUAL -1 )
                    list( APPEND ${RESULTS} ${SEARCHED_ARG})
                else()
                    break()
                endif()
                
            endforeach( SEARCHED_ARG )
            
            # propagate the results and return
            set(${RESULTS} ${${RESULTS}} PARENT_SCOPE )
            return()
            
        endif()    
            
    endforeach()
    
endfunction()