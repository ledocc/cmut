include("${CMAKE_CURRENT_LIST_DIR}/../log.cmake")

# parse semver version like defined by https://semver.org/
# major       : major component result
# minor       : minor component result
# patch       : patch component result
# pre_release : pre_release component result
# build       : build component result
# input       : version string to parse
function(cmut__semver__parse major minor patch pre_release build semver)
    set(CMAKE_CURRENT_FUNCTION "cmut__semver__parse")

    # separate component
    set(semver_regex "^([0-9.]+)(-([^+]+))?(\\+(.*))?$")
    if (${semver} MATCHES ${semver_regex})
        set(semver_core ${CMAKE_MATCH_1})
        set(semver_pre_release ${CMAKE_MATCH_3})
        set(semver_build ${CMAKE_MATCH_5})
    else()
        cmut__log__error("${CMAKE_CURRENT_FUNCTION}" "invalid semver format : ${semver}. Should match ${semver_regex}")
        return()
    endif()


    #parse core component
    set(semver_regex_core "^(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)$")
    if (${semver_core} MATCHES ${semver_regex_core})
        cmut__lang__set_in_parent_scope(${major} ${CMAKE_MATCH_1})
        cmut__lang__set_in_parent_scope(${minor} ${CMAKE_MATCH_2})
        cmut__lang__set_in_parent_scope(${patch} ${CMAKE_MATCH_3})
    else()
        cmut__log__error("${CMAKE_CURRENT_FUNCTION}" "invalid semver core format : \"${semver_core}\". Should match \"${semver_regex_core}\"")
    endif()


    # parse pre-release component
    set(semver_regex_pre_release "^(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*$")
    if (semver_pre_release)
        if (${semver_pre_release} MATCHES ${semver_regex_pre_release})
            cmut__lang__set_in_parent_scope(${pre_release} ${CMAKE_MATCH_0})
        else()
            cmut__log__error("${CMAKE_CURRENT_FUNCTION}" "invalid semver pre-release format : \"${semver_pre_release}\". Should match \"${semver_regex_pre_release}\"")
        endif()
    else()
        cmut__lang__set_in_parent_scope(${pre_release})
    endif()

    # parse build component
    set(semver_regex_build "^[0-9a-zA-Z-]+(\\.[0-9a-zA-Z-]+)*$")
    if (semver_build)
        if (${semver_build} MATCHES ${semver_regex_build})
            cmut__lang__set_in_parent_scope(${build} ${CMAKE_MATCH_0})
        else()
            cmut__log__error("${CMAKE_CURRENT_FUNCTION}" "invalid semver build format : \"${semver_build}\". Should match \"${semver_regex_build}\"")
        endif()
    else()
        cmut__lang__set_in_parent_scope(${build})
    endif()

endfunction()
