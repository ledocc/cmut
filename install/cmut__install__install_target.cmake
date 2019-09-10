

# cmut__install__install_target( target
#                                [COMPONENT component]
#                                [INCLUDES_COMPONENT component]
#                                [INCLUDE_DIRECTORIES include/MyLib [include/MyLib2]] )
# - install library and headers of target
# - generate and install <target name>Target.cmake
#
function(cmut__install__install_target target)

    cmut_deprecated_function( cmut__install__install_target cmut__install__target )
    cmut__install__target( ${target} )

endfunction()
