

# cmut__project__set_version( version [PRERELEASE prerelease] [BUILD build])
# version : version in semver format
# prerelease: overload the prerelease component found in version
# build: overload the build component found in version
#
# define PROJECT_VERSION,            <PROJECT-NAME>_VERSION
#        PROJECT_VERSION_MAJOR,      <PROJECT-NAME>_VERSION_MAJOR
#        PROJECT_VERSION_MINOR,      <PROJECT-NAME>_VERSION_MINOR
#        PROJECT_VERSION_PATCH,      <PROJECT-NAME>_VERSION_PATCH
#        PROJECT_VERSION_PRERELEASE, <PROJECT-NAME>_VERSION_PRERELEASE
#        PROJECT_VERSION_BUILD,      <PROJECT-NAME>_VERSION_BUILD

function(cmut__project__set_version version )

    cmut__lang__function__init_param( cmut__project__set_version )
    cmut__lang__function__add_param( PRERELEASE )
    cmut__lang__function__add_param( BUILD )
    cmut__lang__function__parse_arguments( ${ARGN} )

    cmut__semver__parse( major minor patch prerelease build ${version} )

    cmut__lang__copy_if_defined( ARG_PRERELEASE prerelease )
    cmut__lang__copy_if_defined( ARG_BUILD build )



    macro(cmut__project__set_version_component component value)
        cmut__lang__set_in_parent_scope( ${PROJECT_NAME}_${component} ${value} )
        cmut__lang__set_in_parent_scope( PROJECT_${component} ${value} )
    endmacro()

    cmut__project__set_version_component( VERSION            "${version}"  )
    cmut__project__set_version_component( VERSION_MAJOR      "${major}"    )
    cmut__project__set_version_component( VERSION_MINOR      "${minor}"    )
    cmut__project__set_version_component( VERSION_PATCH      "${patch}"    )
    cmut__project__set_version_component( VERSION_PRERELEASE "${prerelease}" )
    cmut__project__set_version_component( VERSION_BUILD      "${build}"    )

endfunction()



# cmut__project__set_version_from_file( file_path [PRERELEASE prerelease] [BUILD build])
# file_path : file containing version in semver format
# prerelease: overload the prerelease found in version
# build     : overload the build found in version file
macro( cmut__project__set_version_from_file file_path )

    if( NOT EXISTS "${file_path}" )
        cmut__log__fatal( ${CMAKE_CURRENT_FUNCTION} "${file_path} : no such file" )
    endif()

    file( STRINGS "${file_path}" version LIMIT_COUNT 1 )
    set_directory_properties( PROPERTIES CMAKE_CONFIGURE_DEPENDS ${file_path} )

    cmut__project__set_version( ${version} ${ARGN} )

endmacro()
