include("${CMAKE_CURRENT_LIST_DIR}/cmut__install__component_dependency.cmake")



function(cmut__install__add_install_component_targets)

    cmut_deprecated(cmut__install__add_install_component_targets cmut__install__component__make_targets)

    cmut__install__component__make_targets()

endfunction()
