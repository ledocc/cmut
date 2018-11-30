
function(cmut__dependency__print project)

    cmut_info( "[cmut][dependency] : Dependency list of ${project} :" )

    foreach(dependency IN LISTS ${project}_DEPENDENCIES)

        set(dependency_info ${dependency})
        if(DEFINED ${project}_DEPENDENCIES_${dependency}_VERSION)
            set(dependency_info "${dependency_info} ${${project}_DEPENDENCIES_${dependency}_VERSION}")
        endif()

        if(DEFINED ${project}_DEPENDENCIES_${dependency}_REQUIRED)
            set(dependency_info "${dependency_info} (required)")
        endif()

        cmut_info( "[cmut][dependency] : - ${dependency_info}" )
        foreach( components IN LISTS ${project}_DEPENDENCIES_${dependency}_COMPONENTS )
            cmut_info( "[cmut][dependency] :      ${components}" )
        endforeach()

    endforeach()

endfunction()
