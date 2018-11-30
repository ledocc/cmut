
macro( cmut__dependency__set_in_parent_scope project )

    foreach( package IN LISTS ${project}_DEPENDENCIES )

        cmut__utils__set_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_VERSION )
        cmut__utils__set_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_REQUIRED )
        cmut__utils__set_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_FIND_PACKAGE_NAME )
        cmut__utils__set_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_COMPONENTS )
        cmut__utils__set_in_parent_scope_if_defined( ${project}_DEPENDENCIES_${package}_NAMES )

    endforeach()

    cmut__utils__set_in_parent_scope_if_defined( ${project}_DEPENDENCIES )

endmacro()
